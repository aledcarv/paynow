require 'rails_helper'

describe 'user deletes payment method card' do
    it 'successfully' do
        pay_method = PaymentMethod.create!(name: 'Cartão do banco laranja', tax_porcentage: 5,
                                           tax_maximum: 80, status: true, payment_type: :card)

        company = Company.create!(name: 'Codeplay', cnpj: '12365478910111', 
                                  financial_adress: 'Rua Joãozinho', 
                                  financial_email: 'faturamento@codeplay.com.br',
                                  token: SecureRandom.base58(20))

        CardMethod.create!(card_code: 'b04206dj1D7nRVJp2440', company: company, 
                           payment_method: pay_method)

        user = User.create!(email: 'baden@codeplay.com.br', password: '012345', 
                            role: 10, company: company)

        login_as user, scope: :user

        visit root_path
        click_on 'Minha empresa'

        expect { click_on 'Apagar' }.to change { CardMethod.count }.by(-1)
        
        expect(current_path).to eq(user_company_path(Company.last))
        expect(page).to have_content('cartão apagado com sucesso')
    end
end