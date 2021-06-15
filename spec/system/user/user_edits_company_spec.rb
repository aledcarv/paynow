require 'rails_helper'

describe 'user edits company' do
    it 'successfully' do
        company = Company.create!(name: 'Codeplay', cnpj: '12365478910111', 
                        financial_adress: 'Rua Joãozinho', 
                        financial_email: 'faturamento@codeplay.com.br',
                        token: SecureRandom.base58(20))

        user = User.create(email: 'baden@codeplay.com.br', password: '012345', 
                    role: 10, company_id: company.id)

        login_as user, scope: :user
        visit root_path
        click_on 'Minha empresa'
        click_on 'Editar empresa'

        fill_in 'Razão Social', with: 'CodePlay'
        fill_in 'CNPJ', with: '11465485910115'
        fill_in 'Endereço de faturamento', with: 'Rua Dom João'
        fill_in 'Email de faturamento', with: 'economia@codeplay.com.br'
        click_on 'Editar'

        expect(page).to have_content('CodePlay')
        expect(page).to have_content('11465485910115')
        expect(page).to have_content('Rua Dom João')
        expect(page).to have_content('economia@codeplay.com.br')
        expect(page).to have_content(company.token)
    end

    it 'and attributes can not be blank' do
        company = Company.create!(name: 'Codeplay', cnpj: '12365478910111', 
                        financial_adress: 'Rua Joãozinho', 
                        financial_email: 'faturamento@codeplay.com.br',
                        token: SecureRandom.base58(20))

        user = User.create(email: 'baden@codeplay.com.br', password: '012345', 
                    role: 10, company_id: company.id)

        login_as user, scope: :user
        visit root_path
        click_on 'Minha empresa'
        click_on 'Editar empresa'

        fill_in 'Razão Social', with: ''
        fill_in 'CNPJ', with: ''
        fill_in 'Endereço de faturamento', with: ''
        fill_in 'Email de faturamento', with: ''
        click_on 'Editar'

        expect(page).to have_content('não pode ficar em branco', count: 4)
    end

    it 'and generate new token' do
        company = Company.create!(name: 'Codeplay', cnpj: '12365478910111', 
                        financial_adress: 'Rua Joãozinho', 
                        financial_email: 'faturamento@codeplay.com.br',
                        token: SecureRandom.base58(20))

        user = User.create(email: 'baden@codeplay.com.br', password: '012345', 
                    role: 10, company_id: company.id)

        login_as user, scope: :user
        visit root_path
        click_on 'Minha empresa'

        expect { click_on 'Gere um novo token' }.to change { Company.last.token }
        
        expect(current_path).to eq(user_company_path(company))
        expect(page).to have_content('token atualizado com sucesso')
        expect(page).to have_content(Company.last.token)
    end

    it 'and must be logged in to access edit company route' do
        company = Company.create!(name: 'Codeplay', cnpj: '12365478910111',
                                  financial_adress: 'Rua Joãozinho',
                                  financial_email: 'faturamento@codeplay.com.br',
                                  token: SecureRandom.base58(20))
        
        visit edit_user_company_path(company)

        expect(current_path).to eq(new_user_session_path)
    end
end