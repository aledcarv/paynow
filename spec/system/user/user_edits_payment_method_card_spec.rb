require 'rails_helper'

describe 'user edits payment method card' do
    it 'successfully' do
        pay_method = PaymentMethod.create!(name: 'cartão do banco laranja', tax_porcentage: 5,
                                           tax_maximum: 80, status: true, payment_type: :card)

        company = Company.create!(name: 'Codeplay', cnpj: '12365478910111', 
                                  financial_adress: 'Rua Joãozinho', 
                                  financial_email: 'faturamento@codeplay.com.br',
                                  token: SecureRandom.base58(20))

        CardMethod.create!(card_code: '1G0341AB09c8dkwm734m',company: company, 
                           payment_method: pay_method)
        
        user = User.create!(email: 'baden@codeplay.com.br', password: '012345', 
                            role: 10, company: company)

        login_as user, scope: :user

        visit root_path
        click_on 'Minha empresa'
        click_on 'Editar meio de pagamento - cartão'

        fill_in 'Código do cartão', with: 'L00341fB06c84kgmy24h'
        click_on 'Editar'

        expect(page).to have_content('L00341fB06c84kgmy24h')
    end

    it 'and attribute can not be blank' do
        pay_method = PaymentMethod.create!(name: 'Cartão do banco laranja', tax_porcentage: 5,
                                           tax_maximum: 80, status: true, payment_type: :card)

        company = Company.create!(name: 'Codeplay', cnpj: '12365478910111', 
                                  financial_adress: 'Rua Joãozinho', 
                                  financial_email: 'faturamento@codeplay.com.br',
                                  token: SecureRandom.base58(20))

        CardMethod.create!(card_code: '1G0341AB09c8dkwm734m',company: company, 
                           payment_method: pay_method)

        user = User.create!(email: 'baden@codeplay.com.br', password: '012345', 
                            role: 10, company: company)

        login_as user, scope: :user

        visit root_path
        click_on 'Minha empresa'
        click_on 'Editar meio de pagamento - cartão'

        fill_in 'Código do cartão', with: ''
        click_on 'Editar'

        expect(page).to have_content('não pode ficar em branco', count: 1)
    end

    it 'and attribute must be unique' do
        pay_method = PaymentMethod.create!(name: 'cartão do banco laranja', tax_porcentage: 5,
                                           tax_maximum: 80, status: true, payment_type: :card)

        company = Company.create!(name: 'Codeplay', cnpj: '12365478910111', 
                                  financial_adress: 'Rua Joãozinho',
                                  financial_email: 'faturamento@codeplay.com.br',
                                  token: SecureRandom.base58(20))

        card = CardMethod.create!(card_code: '1G0341AB09c8dkwm734m',company: company, 
                                  payment_method: pay_method)
        
        CardMethod.create!(card_code: 'b04206dj1D7nRVJp2440', company: company, 
                           payment_method: pay_method)

        user = User.create!(email: 'baden@codeplay.com.br', password: '012345', 
                            role: 10, company: company)

        login_as user, scope: :user

        visit edit_user_payment_method_card_method_path(pay_method, card)

        fill_in 'Código do cartão', with: 'b04206dj1D7nRVJp2440'
        click_on 'Editar'

        expect(page).to have_content('já está em uso')
    end

    it 'must be logged in to access route' do
        pay_method = PaymentMethod.create!(name: 'cartão do banco laranja', tax_porcentage: 5,
                                           tax_maximum: 80, status: true, payment_type: :card)

        company = Company.create!(name: 'Codeplay', cnpj: '12365478910111', 
                                  financial_adress: 'Rua Joãozinho', 
                                  financial_email: 'faturamento@codeplay.com.br',
                                  token: SecureRandom.base58(20))

        card_method = CardMethod.create!(card_code: 'b04206dj1D7nRVJp2440', company: company,
                                         payment_method: pay_method)

        visit edit_user_payment_method_card_method_path(pay_method, card_method)

        expect(current_path).to eq(new_user_session_path)
    end
end