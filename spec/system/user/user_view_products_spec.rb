require 'rails_helper'

describe 'user view products' do
    it 'successfully' do
        company = Company.create!(name: 'Codeplay', cnpj: '12365478910111', 
                                  financial_adress: 'Rua Joãozinho', 
                                  financial_email: 'faturamento@codeplay.com.br',
                                  token: SecureRandom.base58(20))
                                  
        Product.create!(name: 'Curso de Ruby', price: 30, boleto_discount: 0, 
                        pix_discount: 0, card_discount: 4, company: company,
                        token: SecureRandom.base58(20))
        
        Product.create!(name: 'Curso de Elixir', price: 25, boleto_discount: 2,
                        pix_discount: 0, card_discount: 5, company: company,
                        token: SecureRandom.base58(20))

        user = User.create!(email: 'baden@codeplay.com.br', password: '012345', 
                            role: 10, company_id: company.id)
        
        login_as user, scope: :user

        visit root_path
        click_on 'Minha empresa'
        click_on 'Meus produtos'

        expect(page).to have_content('Curso de Ruby')
        expect(page).to have_content('R$ 30,00')
        expect(page).to have_content('Curso de Elixir')
        expect(page).to have_content('R$ 25,00')
    end

    it 'and there is no product' do
        company = Company.create!(name: 'Codeplay', cnpj: '12365478910111', 
                                  financial_adress: 'Rua Joãozinho', 
                                  financial_email: 'faturamento@codeplay.com.br',
                                  token: SecureRandom.base58(20))

        user = User.create!(email: 'baden@codeplay.com.br', password: '012345', 
                            role: 10, company_id: company.id)
        
        login_as user, scope: :user

        visit root_path
        click_on 'Minha empresa'
        click_on 'Meus produtos'

        expect(page).to have_content('Nenhum produto disponível')
    end

    it 'and view details' do
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

        expect(page).to have_content('Curso de Ruby')
        expect(page).to have_content('R$ 30,00')
        expect(page).to have_content('0,0%')
        expect(page).to have_content('0,0%')
        expect(page).to have_content('4,0%')
        expect(page).to have_content(product.token)
    end

    it 'and return to my products page' do
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
        click_on 'Voltar'

        expect(current_path).to eq(user_company_products_path(company))
    end

    it 'and must be logged in to access route' do
        company = Company.create!(name: 'Codeplay', cnpj: '12365478910111', 
                                  financial_adress: 'Rua Joãozinho', 
                                  financial_email: 'faturamento@codeplay.com.br',
                                  token: SecureRandom.base58(20))

        visit user_company_products_path(company)

        expect(current_path).to eq(new_user_session_path)
    end

    it 'and must be logged in to access show route' do
        company = Company.create!(name: 'Codeplay', cnpj: '12365478910111',
                                  financial_adress: 'Rua Joãozinho', 
                                  financial_email: 'faturamento@codeplay.com.br',
                                  token: SecureRandom.base58(20))

        product = Product.create!(name: 'Curso de Ruby', price: 30, boleto_discount: 0, 
                                  pix_discount: 0, card_discount: 4, company: company,
                                  token: SecureRandom.base58(20))

        visit user_company_product_path(company, product)

        expect(current_path).to eq(new_user_session_path)
    end
end