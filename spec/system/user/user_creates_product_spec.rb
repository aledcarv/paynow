require 'rails_helper'

describe 'user creates products' do
    it 'successfully' do
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
        click_on 'Cadastrar um produto'

        fill_in 'Nome', with: 'Curso de Ruby'
        fill_in 'Preço', with: 30
        fill_in 'Desconto para cartão', with: 5
        click_on 'Cadastrar'

        expect(current_path).to eq(user_company_product_path(company, Product.last))
        expect(page).to have_content('Curso de Ruby')
        expect(page).to have_content('R$ 30,00')
        expect(page).to have_content('0,0%')
        expect(page).to have_content('0,0%')
        expect(page).to have_content('5,0%')
        expect(page).to have_content('Produto criado com sucesso')
        expect(page).to have_content(Product.last.token)
    end

    it 'and attributes can not be blank' do
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
        click_on 'Cadastrar um produto'

        fill_in 'Nome', with: ''
        fill_in 'Preço', with: ''
        fill_in 'Desconto para boleto', with: ''
        fill_in 'Desconto para pix', with: ''
        fill_in 'Desconto para cartão', with: 5
        click_on 'Cadastrar'

        expect(page).to have_content('não pode ficar em branco', count: 2)
    end

    it 'and attributes must be unique' do
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
        click_on 'Cadastrar um produto'

        fill_in 'Nome', with: 'Curso de ruby'
        fill_in 'Preço', with: 30
        fill_in 'Desconto para boleto', with: ''
        fill_in 'Desconto para pix', with: ''
        fill_in 'Desconto para cartão', with: 5
        click_on 'Cadastrar'

        expect(page).to have_content('já está em uso')
    end
end