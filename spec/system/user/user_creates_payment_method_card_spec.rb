require 'rails_helper'

describe 'user wants payment method card' do
    it 'successfully' do
        pay_method = PaymentMethod.create!(name: 'Cartão do banco laranja', tax_porcentage: 5,
                                           tax_maximum: 80, status: true, payment_type: :card)

        user_admin_login
        visit root_path
        click_on 'Meios de pagamento'
        click_on 'Cartão do banco laranja'
        click_on 'Selecionar este meio de pagamento'

        fill_in 'Código do cartão', with: '1G0341AB09c8dkwm734m'
        click_on 'Selecionar'

        expect(current_path).to eq(user_company_path(Company.last))
        expect(page).to have_content('Cartão do banco laranja')
        expect(page).to have_content('1G0341AB09c8dkwm734m')
        expect(page).to have_content('Meio de pagamento selecionado')
    end

    it 'and attributes can not be blank' do
        pay_method = PaymentMethod.create!(name: 'Cartão do banco laranja', tax_porcentage: 5,
                                           tax_maximum: 80, status: true, payment_type: :card)

        user_admin_login
        visit root_path
        click_on 'Meios de pagamento'
        click_on 'Cartão do banco laranja'
        click_on 'Selecionar este meio de pagamento'

        fill_in 'Código do cartão', with: ''
        click_on 'Selecionar'

        expect(page).to have_content('não pode ficar em branco', count: 1)
    end

    it 'and attribute must be unique' do
        pay_method = PaymentMethod.create!(name: 'Cartão Mestrecard', tax_porcentage: 5,
                                           tax_maximum: 80, status: true, payment_type: :card)
    
        company = Company.create!(name: 'Codeplay', cnpj: '12365478910111', 
                                  financial_adress: 'Rua Joãozinho', 
                                  financial_email: 'faturamento@codeplay.com.br',
                                  token: SecureRandom.base58(20))

        CardMethod.create!(card_code: '1G0341AB09c8dkwm734m', company: company, 
                           payment_method: pay_method)
                                  
        user = User.create!(email: 'baden@codeplay.com.br', password: '012345', 
                            role: 10, company: company)

        login_as user, scope: :user

        visit root_path
        click_on 'Meios de pagamento'
        click_on 'Cartão Mestrecard'
        click_on 'Selecionar este meio de pagamento'

        fill_in 'Código do cartão', with: '1G0341AB09c8dkwm734m'
        click_on 'Selecionar'

        expect(page).to have_content('já está em uso')
    end

    it 'must be logged in to access route' do
        pay_method = PaymentMethod.create!(name: 'Cartão do banco laranja', tax_porcentage: 5,
                                           tax_maximum: 80, status: true, payment_type: :card)

        company = Company.create!(name: 'Codeplay', cnpj: '12365478910111', 
                                  financial_adress: 'Rua Joãozinho', 
                                  financial_email: 'faturamento@codeplay.com.br',
                                  token: SecureRandom.base58(20))

        visit new_user_payment_method_card_method_path(pay_method)

        expect(current_path).to eq(new_user_session_path)
    end
end