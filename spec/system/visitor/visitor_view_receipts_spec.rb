require 'rails_helper'

describe 'visitor view receipts' do
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
                                status: :pending, final_client_name: 'Pedro Alberto', final_client_cpf: '12345678960',
                                company_token: company.token, product_token: product.token, payment_method: pay_method.payment_type)

        receipt = Receipt.create!(due_date: charge.due_date, paid_date: Date.current, 
                                  authorization_code: SecureRandom.base58(20), charge: charge)

        visit receipt_path(Receipt.last.authorization_code)
        expect(page).to have_content(receipt.due_date)
        expect(page).to have_content(receipt.paid_date)
        expect(page).to have_content(receipt.authorization_code)
    end
end