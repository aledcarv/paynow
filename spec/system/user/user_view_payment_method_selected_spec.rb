require 'rails_helper'

describe 'user view payment method selected' do
    it 'successfully' do
        pay_method = PaymentMethod.create!(name: 'Boleto do banco laranja', tax_porcentage: 5,
                                           tax_maximum: 80, status: true, payment_type: :boleto)

        company = Company.create!(name: 'Codeplay', cnpj: '12365478910111',
                                  financial_adress: 'Rua Joãozinho',
                                  financial_email: 'faturamento@codeplay.com.br',
                                  token: SecureRandom.base58(20))

        BoletoMethod.create!(bank_code: '341', agency_number: '0123', bank_account: '12233322',
                             company: company, payment_method: pay_method)
        
        user = User.create!(email: 'baden@codeplay.com.br', password: '012345',
                            role: 10, company: company)

        login_as user, scope: :user

        visit root_path
        click_on 'Minha empresa'

        expect(page).to have_content('Boleto do banco laranja')
        expect(page).to have_content('341')
        expect(page).to have_content('0123')
        expect(page).to have_content('12233322')
    end

    it 'and there is no payment method boleto selected' do
        pay_method = PaymentMethod.create!(name: 'Boleto do banco laranja', tax_porcentage: 5,
            tax_maximum: 80, status: true, payment_type: :boleto)

        company = Company.create!(name: 'Codeplay', cnpj: '12365478910111',
                                  financial_adress: 'Rua Joãozinho',
                                  financial_email: 'faturamento@codeplay.com.br',
                                  token: SecureRandom.base58(20))

        user = User.create!(email: 'baden@codeplay.com.br', password: '012345',
                            role: 10, company: company)

        login_as user, scope: :user

        visit root_path
        click_on 'Minha empresa'

        expect(page).to have_content('Nenhum meio de pagamento boleto selecionado')
    end
end