require 'rails_helper'

describe 'admin edits charge status' do
    it 'successfully' do
        company = Company.create!(name: 'Codeplay', cnpj: '12365478910111',
                                      financial_adress: 'Rua Joãozinho',
                                      financial_email: 'faturamento@codeplay.com.br')
                                      
        product = Product.create!(name: 'Curso de Ruby', price: 30, boleto_discount: 5, 
                                    pix_discount: 2, card_discount: 4, company: company)

        pay_method = PaymentMethod.new(name: 'Boleto do banco laranja', tax_porcentage: 5,
                                        tax_maximum: 80, status: true, payment_type: :boleto)

        final_client = FinalClient.create!(name: 'Pedro Alberto', cpf: '12345678960')

        charge = Charge.create!(original_value: 30.0, discount_value: 28.8, token: SecureRandom.base58(20),
                       status: :pendente, final_client_name: 'Pedro Alberto', final_client_cpf: '12345678960',
                       company_token: company.token, product_token: product.token, payment_method: pay_method.payment_type)

        admin_login
        visit root_path
        click_on 'Cobranças'
        click_on 'Pedro Alberto'
        select 'aprovado', from: 'Status'
        click_on 'Atualizar status da cobrança'

        expect(current_path).to eq(admin_charge_path(charge))
        expect(page).to have_content('aprovado')
        expect(page).to have_content('Status da cobrança atualizado com sucesso')
    end
    
    it 'and can not update status' do
        company = Company.create!(name: 'Codeplay', cnpj: '12365478910111',
                                      financial_adress: 'Rua Joãozinho',
                                      financial_email: 'faturamento@codeplay.com.br')
                                      
        product = Product.create!(name: 'Curso de Ruby', price: 30, boleto_discount: 5, 
                                    pix_discount: 2, card_discount: 4, company: company)

        pay_method = PaymentMethod.new(name: 'Boleto do banco laranja', tax_porcentage: 5,
                                        tax_maximum: 80, status: true, payment_type: :boleto)

        final_client = FinalClient.create!(name: 'Pedro Alberto', cpf: '12345678960')

        charge = Charge.create!(original_value: 30.0, discount_value: 28.8, token: SecureRandom.base58(20),
                       status: :pendente, final_client_name: 'Pedro Alberto', final_client_cpf: '12345678960',
                       company_token: company.token, product_token: product.token, payment_method: pay_method.payment_type)

        admin_login
        visit root_path
        click_on 'Cobranças'
        click_on 'Pedro Alberto'

        expect(current_path).to eq(admin_charge_path(charge))
        within 'dl' do
            expect(page).to_not have_content('aprovado')
        end
    end
end