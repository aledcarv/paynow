require 'rails_helper'

describe 'user deletes product' do
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

        expect { click_on 'Apagar produto' }.to change { Product.count }.by(-1)
        expect(current_path).to eq(user_company_products_path(company))
        expect(page).to have_content('Produto apagado com sucesso')
    end
end