require 'rails_helper'

describe 'admin view company' do
    it 'successfully' do
        Company.create!(name: 'Codeplay', cnpj: '12365478910111', 
                        financial_adress: 'Rua Joãozinho', 
                        financial_email: 'faturamento@codeplay.com.br',
                        token: SecureRandom.base58(20))

        Company.create!(name: 'Apple', cnpj: '75266488314151', 
                        financial_adress: 'Rua Dom João', 
                        financial_email: 'faturamento@apple.com.br',
                        token: SecureRandom.base58(20))

        Company.create!(name: 'SuperSom', cnpj: '41163468365398', 
                        financial_adress: 'Rua Juvenal', 
                        financial_email: 'faturamento@supersom.com.br',
                        token: SecureRandom.base58(20))

        admin_login
        visit root_path
        click_on 'Empresas'

        expect(page).to have_content('Codeplay')
        expect(page).to have_content('Rua Joãozinho')
        expect(page).to have_content('faturamento@codeplay.com.br')
        expect(page).to have_content('Apple')
        expect(page).to have_content('Rua Dom João')
        expect(page).to have_content('faturamento@apple.com.br')
        expect(page).to have_content('SuperSom')
        expect(page).to have_content('Rua Juvenal')
        expect(page).to have_content('faturamento@supersom.com.br')
    end

    it 'and there is no company' do
        admin_login
        visit root_path
        click_on 'Empresas'

        expect(page).to have_content('Nenhuma empresa disponível')
    end

    it 'and view detail' do
        company = Company.create!(name: 'Codeplay', cnpj: '12365478910111',
                                  financial_adress: 'Rua Joãozinho',
                                  financial_email: 'faturamento@codeplay.com.br',
                                  token: SecureRandom.base58(20))
        
        admin_login                                  
        visit root_path
        click_on 'Empresas'
        click_on 'Codeplay'

        expect(page).to have_content('Codeplay')
        expect(page).to have_content('12365478910111')
        expect(page).to have_content('Rua Joãozinho')
        expect(page).to have_content('faturamento@codeplay.com.br')
        expect(page).to have_content(company.token)
    end

    it 'and return to company page' do
        company = Company.create!(name: 'Codeplay', cnpj: '12365478910111',
                                  financial_adress: 'Rua Joãozinho',
                                  financial_email: 'faturamento@codeplay.com.br',
                                  token: SecureRandom.base58(20))

        admin_login
        visit root_path
        click_on 'Empresas'
        click_on 'Codeplay'
        click_on 'Voltar'

        expect(current_path).to eq(admin_companies_path)
    end
end