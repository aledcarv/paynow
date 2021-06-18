require 'rails_helper'

RSpec.describe PixMethod, type: :model do
  it { should validate_presence_of(:bank_code) }
  it { should validate_presence_of(:key_pix) }

  it { should validate_length_of(:bank_code).is_equal_to(3) }
  it { should validate_length_of(:key_pix).is_equal_to(20) }

  context 'validating uniqueness' do
    it 'successfully' do
      pay_method = PaymentMethod.create!(name: 'Pix do banco laranja', tax_porcentage: 5,
                                         tax_maximum: 80, status: true, payment_type: :pix)
    
      company = Company.create!(name: 'Codeplay', cnpj: '12365478910111',
                                financial_adress: 'Rua Joãozinho',
                                financial_email: 'faturamento@codeplay.com.br',
                                token: SecureRandom.base58(20))
      
      PixMethod.create!(bank_code: '341', key_pix: 'h23jd012d93j238f56h2',
                        company: company, payment_method: pay_method)
      
      User.create!(email: 'baden@codeplay.com.br', password: '012345', 
                   role: 10, company: company)
  
      should validate_uniqueness_of(:key_pix)
    end
  end
end
