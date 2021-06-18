require 'rails_helper'

describe 'user wants payment method boleto' do
    it 'successfully' do
        pay_method = PaymentMethod.create!(name: 'Boleto do banco laranja', tax_porcentage: 5,
                                           tax_maximum: 80, status: true, payment_type: :boleto)

        user_admin_login
        visit root_path
        click_on 'Meios de pagamento'
        click_on 'Boleto do banco laranja'
        click_on 'Selecionar este meio de pagamento'

        fill_in 'Código do banco', with: '341'
        fill_in 'Número da agência', with: '0123'
        fill_in 'Conta bancária', with: '12233322'
        click_on 'Selecionar'

        expect(current_path).to eq(user_company_path(Company.last))
        expect(page).to have_content('Boleto do banco laranja')
        expect(page).to have_content('341')
        expect(page).to have_content('0123')
        expect(page).to have_content('12233322')
        expect(page).to have_content('Meio de pagamento selecionado')
    end

    it 'and attributes can not be blank' do
        pay_method = PaymentMethod.create!(name: 'Boleto do banco laranja', tax_porcentage: 5,
                                           tax_maximum: 80, status: true, payment_type: :boleto)

        user_admin_login
        visit root_path
        click_on 'Meios de pagamento'
        click_on 'Boleto do banco laranja'
        click_on 'Selecionar este meio de pagamento'

        fill_in 'Código do banco', with: ''
        fill_in 'Número da agência', with: ''
        fill_in 'Conta bancária', with: ''
        click_on 'Selecionar'

        expect(page).to have_content('não pode ficar em branco', count: 3)
    end

    it 'and attribute must be unique' do
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
        click_on 'Meios de pagamento'
        click_on 'Boleto do banco laranja'
        click_on 'Selecionar este meio de pagamento'

        fill_in 'Código do banco', with: '341'
        fill_in 'Número da agência', with: '0123'
        fill_in 'Conta bancária', with: '12233322'
        click_on 'Selecionar'

        expect(page).to have_content('já está em uso')
    end

    it 'must be logged in to access route' do
        pay_method = PaymentMethod.create!(name: 'Boleto do banco laranja', tax_porcentage: 5,
                                           tax_maximum: 80, status: true, payment_type: :boleto)

        company = Company.create!(name: 'Codeplay', cnpj: '12365478910111', 
                                  financial_adress: 'Rua Joãozinho', 
                                  financial_email: 'faturamento@codeplay.com.br',
                                  token: SecureRandom.base58(20))

        visit new_user_payment_method_boleto_method_path(pay_method)

        expect(current_path).to eq(new_user_session_path)
    end
end