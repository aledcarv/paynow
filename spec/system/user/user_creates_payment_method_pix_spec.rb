require 'rails_helper'

describe 'user wants payment method pix' do
    it 'successfully' do
        pay_method = PaymentMethod.create!(name: 'Pix do banco laranja', tax_porcentage: 5,
                                           tax_maximum: 80, status: true, payment_type: :pix)

        user_admin_login
        visit root_path
        click_on 'Meios de pagamento'
        click_on 'Pix do banco laranja'
        click_on 'Selecionar este meio de pagamento'

        fill_in 'Código do banco', with: '341'
        fill_in 'Chave pix', with: 'AB120kdjND76RVJJ22l0'
        click_on 'Selecionar'

        expect(current_path).to eq(user_company_path(Company.last))
        expect(page).to have_content('Pix do banco laranja')
        expect(page).to have_content('341')
        expect(page).to have_content('AB120kdjND76RVJJ22l0')
        expect(page).to have_content('Meio de pagamento selecionado')
    end

    it 'and attributes can not be blank' do
        pay_method = PaymentMethod.create!(name: 'Pix do banco laranja', tax_porcentage: 5,
                                           tax_maximum: 80, status: true, payment_type: :pix)

        user_admin_login
        visit root_path
        click_on 'Meios de pagamento'
        click_on 'Pix do banco laranja'
        click_on 'Selecionar este meio de pagamento'

        fill_in 'Código do banco', with: ''
        fill_in 'Chave pix', with: ''
        click_on 'Selecionar'

        expect(page).to have_content('não pode ficar em branco', count: 2)
    end

    it 'and attribute must be unique' do
        pay_method = PaymentMethod.create!(name: 'Pix do banco laranja', tax_porcentage: 5,
                                           tax_maximum: 80, status: true, payment_type: :pix)
    
        company = Company.create!(name: 'Codeplay', cnpj: '12365478910111', 
                                  financial_adress: 'Rua Joãozinho', 
                                  financial_email: 'faturamento@codeplay.com.br',
                                  token: SecureRandom.base58(20))

        PixMethod.create!(bank_code: '341', key_pix: 'h23jd012d93j238f56h2',
                          company: company, payment_method: pay_method)
                                  
        user = User.create!(email: 'baden@codeplay.com.br', password: '012345', 
                            role: 10, company: company)

        login_as user, scope: :user

        visit root_path
        click_on 'Meios de pagamento'
        click_on 'Pix do banco laranja'
        click_on 'Selecionar este meio de pagamento'

        fill_in 'Código do banco', with: '341'
        fill_in 'Chave pix', with: 'h23jd012d93j238f56h2'
        click_on 'Selecionar'

        expect(page).to have_content('já está em uso')
    end

    it 'must be logged in to access route' do
        pay_method = PaymentMethod.create!(name: 'pix do banco laranja', tax_porcentage: 5,
                                           tax_maximum: 80, status: true, payment_type: :pix)

        company = Company.create!(name: 'Codeplay', cnpj: '12365478910111', 
                                  financial_adress: 'Rua Joãozinho', 
                                  financial_email: 'faturamento@codeplay.com.br',
                                  token: SecureRandom.base58(20))

        visit new_user_payment_method_pix_method_path(pay_method)

        expect(current_path).to eq(new_user_session_path)
    end
end