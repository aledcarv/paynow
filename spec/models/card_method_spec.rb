require 'rails_helper'

RSpec.describe CardMethod, type: :model do
  it { should validate_presence_of(:card_code) }
  it { should validate_length_of(:card_code).is_equal_to(20) }

  context 'validating uniqueness' do
    it 'successfully' do
      pay_method = PaymentMethod.create!(name: 'Cartão do banco laranja', tax_porcentage: 5,
                                         tax_maximum: 80, status: true, payment_type: :card)
    
      company = Company.create!(name: 'Codeplay', cnpj: '12365478910111',
                                financial_adress: 'Rua Joãozinho',
                                financial_email: 'faturamento@codeplay.com.br',
                                token: SecureRandom.base58(20))
      
      CardMethod.create!(card_code: 'h23jd012d93j238f56h2', company: company, 
                         payment_method: pay_method)
      
      User.create!(email: 'baden@codeplay.com.br', password: '012345', 
                   role: 10, company: company)
  
      should validate_uniqueness_of(:card_code)
    end
  end
end
