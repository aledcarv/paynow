require 'rails_helper'

RSpec.describe Product, type: :model do
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:price) }

  context 'validating uniqueness' do
    it 'successfully' do
      company = Company.create!(name: 'Codeplay', cnpj: '12365478910111',
                                financial_adress: 'Rua Joãozinho',
                                financial_email: 'faturamento@codeplay.com.br',
                                token: SecureRandom.base58(20))
      
      Product.create!(name: 'Curso de Ruby', price: 30, boleto_discount: 0, 
                      pix_discount: 0, card_discount: 4, company: company)
      
      User.create!(email: 'baden@codeplay.com.br', password: '012345', 
                   role: 10, company: company)
  
      should validate_uniqueness_of(:name).case_insensitive
    end
  end
end
