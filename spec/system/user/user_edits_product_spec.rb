require 'rails_helper'

describe 'user edits products' do
    it 'successfully' do
        company = Company.create!(name: 'Codeplay', cnpj: '12365478910111', 
                                  financial_adress: 'Rua Joãozinho', 
                                  financial_email: 'faturamento@codeplay.com.br',
                                  token: SecureRandom.base58(20))
                                  
        Product.create!(name: 'Curso de Ruby', price: 30, boleto_discount: 0, 
                        pix_discount: 0, card_discount: 4, company: company,
                        token: SecureRandom.base58(20))

        user = User.create!(email: 'baden@codeplay.com.br', password: '012345', 
                            role: 10, company_id: company.id)
        
        login_as user, scope: :user

        visit root_path
        click_on 'Minha empresa'
        click_on 'Meus produtos'
        click_on 'Curso de Ruby'
        click_on 'Editar produto'

        fill_in 'Nome', with: 'Curso de Ruby on Rails'
        fill_in 'Preço', with: 25
        fill_in 'Desconto para boleto', with: 4
        fill_in 'Desconto para pix', with: 2
        fill_in 'Desconto para cartão', with: 5
        click_on 'Editar'

        expect(current_path).to eq(user_company_product_path(company, Product.last))
        expect(page).to have_content('Curso de Ruby on Rails')
        expect(page).to have_content('R$ 25,00')
        expect(page).to have_content('4,0%')
        expect(page).to have_content('2,0%')
        expect(page).to have_content('5,0%')
        expect(page).to have_content('Produto editado com sucesso')
    end

    it 'and attributes can not be blank' do
        company = Company.create!(name: 'Codeplay', cnpj: '12365478910111', 
                                  financial_adress: 'Rua Joãozinho', 
                                  financial_email: 'faturamento@codeplay.com.br',
                                  token: SecureRandom.base58(20))
                                  
        Product.create!(name: 'Curso de Ruby', price: 30, boleto_discount: 0, 
                        pix_discount: 0, card_discount: 4, company: company,
                        token: SecureRandom.base58(20))

        user = User.create!(email: 'baden@codeplay.com.br', password: '012345', 
                            role: 10, company_id: company.id)
        
        login_as user, scope: :user

        visit root_path
        click_on 'Minha empresa'
        click_on 'Meus produtos'
        click_on 'Curso de Ruby'
        click_on 'Editar produto'

        fill_in 'Nome', with: ''
        fill_in 'Preço', with: ''
        click_on 'Editar'

        expect(page).to have_content('não pode ficar em branco', count: 2)
    end

    it 'and attribute must be unique' do
        company = Company.create!(name: 'Codeplay', cnpj: '12365478910111', 
                                  financial_adress: 'Rua Joãozinho', 
                                  financial_email: 'faturamento@codeplay.com.br',
                                  token: SecureRandom.base58(20))
                                  
        Product.create!(name: 'Curso de Ruby', price: 30, boleto_discount: 0, 
                        pix_discount: 0, card_discount: 4, company: company,
                        token: SecureRandom.base58(20))
        
        Product.create!(name: 'Curso de Elixir', price: 25, boleto_discount: 0, 
                        pix_discount: 0, card_discount: 4, company: company,
                        token: SecureRandom.base58(20))

        user = User.create!(email: 'baden@codeplay.com.br', password: '012345', 
                            role: 10, company_id: company.id)
        
        login_as user, scope: :user

        visit root_path
        click_on 'Minha empresa'
        click_on 'Meus produtos'
        click_on 'Curso de Ruby'
        click_on 'Editar produto'

        fill_in 'Nome', with: 'Curso de Elixir'
        fill_in 'Preço', with: 25
        click_on 'Editar'

        expect(page).to have_content('já está em uso')
    end

    it 'and return to my products page' do
        company = Company.create!(name: 'Codeplay', cnpj: '12365478910111', 
                                  financial_adress: 'Rua Joãozinho', 
                                  financial_email: 'faturamento@codeplay.com.br',
                                  token: SecureRandom.base58(20))
                                  
        product = Product.create!(name: 'Curso de Ruby', price: 30, boleto_discount: 0, 
                                  pix_discount: 0, card_discount: 4, company: company,
                                  token: SecureRandom.base58(20))

        user = User.create!(email: 'baden@codeplay.com.br', password: '012345', 
                            role: 10, company_id: company.id)
        
        login_as user, scope: :user

        visit root_path
        click_on 'Minha empresa'
        click_on 'Meus produtos'
        click_on 'Curso de Ruby'
        click_on 'Editar produto'
        click_on 'Voltar'

        expect(current_path).to eq(user_company_product_path(company, product))
    end

    it 'and must be logged in to access edit route' do
        company = Company.create!(name: 'Codeplay', cnpj: '12365478910111',
                                  financial_adress: 'Rua Joãozinho', 
                                  financial_email: 'faturamento@codeplay.com.br',
                                  token: SecureRandom.base58(20))

        product = Product.create!(name: 'Curso de Ruby', price: 30, boleto_discount: 0, 
                                  pix_discount: 0, card_discount: 4, company: company,
                                  token: SecureRandom.base58(20))

        visit edit_user_company_product_path(company, product)

        expect(current_path).to eq(new_user_session_path)
    end
end