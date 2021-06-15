require 'rails_helper'

describe 'admin edits company' do
    it 'successfully' do
        company = Company.create!(name: 'Codeplay', cnpj: '12365478910111',
                                  financial_adress: 'Rua Joãozinho',
                                  financial_email: 'faturamento@codeplay.com.br',
                                  token: SecureRandom.base58(20))

        admin_login
        visit root_path
        click_on 'Empresas'
        click_on 'Codeplay'
        click_on 'Editar empresa'

        fill_in 'Razão Social', with: 'CodePlay'
        fill_in 'CNPJ', with: '98265573916131'
        fill_in 'Endereço de faturamento', with: 'Rua Dom João'
        fill_in 'Email de faturamento', with: 'financeiro@codeplay.com.br'
        click_on 'Editar'

        expect(current_path).to eq(admin_company_path(company))
        expect(page).to have_content('CodePlay')
        expect(page).to have_content('98265573916131')
        expect(page).to have_content('Rua Dom João')
        expect(page).to have_content('financeiro@codeplay.com.br')
        expect(page).to have_content(company.token)
    end

    it 'and attribute must not be blank' do
        company = Company.create!(name: 'Codeplay', cnpj: '12365478910111', 
                        financial_adress: 'Rua Joãozinho', 
                        financial_email: 'faturamento@codeplay.com.br',
                        token: SecureRandom.base58(20))

        admin_login
        visit root_path
        click_on 'Empresas'
        click_on 'Codeplay'
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

        admin_login
        visit root_path
        click_on 'Empresas'
        click_on 'Codeplay'

        expect { click_on 'Gere um novo token' }.to change { Company.last.token }
        
        expect(current_path).to eq(admin_company_path(company))
        expect(page).to have_content('token atualizado com sucesso')
        expect(page).to have_content(Company.last.token)
    end

    it 'and can not access edit route with login' do
        company = Company.create!(name: 'Codeplay', cnpj: '12365478910111',
                                  financial_adress: 'Rua Joãozinho',
                                  financial_email: 'faturamento@codeplay.com.br',
                                  token: SecureRandom.base58(20))
        
        visit edit_admin_company_path(company)

        expect(current_path).to eq(new_admin_session_path)
    end
end