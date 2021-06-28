require 'rails_helper'

describe 'admin view charges' do
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
        click_on 'Empresas'
        click_on 'Codeplay'
        click_on 'Cobranças'

        expect(current_path).to eq(admin_charges_path)
        expect(page).to have_content('Todas as cobranças')
        expect(page).to have_content('Pedro Alberto')
        expect(page).to have_content(charge.token)
        expect(page).to have_content('R$ 30,00')
        expect(page).to have_content('R$ 28,80')
    end

    it 'and there is no charges' do
        company = Company.create!(name: 'Codeplay', cnpj: '12365478910111',
                                      financial_adress: 'Rua Joãozinho',
                                      financial_email: 'faturamento@codeplay.com.br')
                                      
        product = Product.create!(name: 'Curso de Ruby', price: 30, boleto_discount: 5, 
                                    pix_discount: 2, card_discount: 4, company: company)

        pay_method = PaymentMethod.new(name: 'Boleto do banco laranja', tax_porcentage: 5,
                                        tax_maximum: 80, status: true, payment_type: :boleto)

        final_client = FinalClient.create!(name: 'Pedro Alberto', cpf: '12345678960')

        admin_login
        visit root_path
        click_on 'Empresas'
        click_on 'Codeplay'
        click_on 'Cobranças'

        expect(page).to have_content('Nenhuma cobrança disponível')
    end

    it 'and view details' do
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

        expect(page).to have_content('Pedro Alberto')
        expect(page).to have_content('12345678960')
        expect(page).to have_content(charge.token)
        expect(page).to have_content('R$ 30,00')
        expect(page).to have_content('R$ 28,80')
        expect(page).to have_content('pendente')
        expect(page).to have_content(company.token)
        expect(page).to have_content(product.token)
        expect(page).to have_content(pay_method.payment_type)
    end

    it 'and can not view charges without login' do
        visit admin_charges_path

        expect(current_path).to eq(new_admin_session_path)
    end

    it 'and can not access specific charge without login' do
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

        visit admin_charge_path(charge)

        expect(current_path).to eq(new_admin_session_path)
    end
end