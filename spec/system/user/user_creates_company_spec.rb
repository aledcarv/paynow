require 'rails_helper'

describe 'user creates company' do
    it 'successfully' do
        user_login
    
        visit root_path
        click_on 'Cadastrar empresa'
    
        fill_in 'Razão Social', with: 'Codeplay'
        fill_in 'CNPJ', with: '12365478910111'
        fill_in 'Endereço de faturamento', with: 'Rua Joãozinho'
        fill_in 'Email de faturamento', with: 'faturamento@codeplay.com.br'
        click_on 'Cadastrar'
    
        expect(page).to have_content('Codeplay')
        expect(page).to have_content('12365478910111')
        expect(page).to have_content('Rua Joãozinho')
        expect(page).to have_content('faturamento@codeplay.com.br')
    end

    it 'and attributes can not be blank' do
        user_login

        visit root_path
        click_on 'Cadastrar empresa'

        fill_in 'Razão Social', with: ''
        fill_in 'CNPJ', with: ''
        fill_in 'Endereço de faturamento', with: ''
        fill_in 'Email de faturamento', with: ''
        click_on 'Cadastrar'

        expect(page).to have_content('não pode ficar em branco', count: 4)
    end

    it 'and attributes must be unique' do
        Company.create!(name: 'Codeplay', cnpj: '12365478910111', 
                        financial_adress: 'Rua Joãozinho', 
                        financial_email: 'faturamento@codeplay.com.br',
                        token: SecureRandom.base58(20))

        user_login
        visit root_path
        click_on 'Cadastrar empresa'

        fill_in 'Razão Social', with: 'Codeplay'
        fill_in 'CNPJ', with: '12365478910111'
        fill_in 'Endereço de faturamento', with: 'Rua Joãozinho'
        fill_in 'Email de faturamento', with: 'faturamento@codeplay.com.br'
        click_on 'Cadastrar'

        expect(page).to have_content('já está em uso')
    end
end