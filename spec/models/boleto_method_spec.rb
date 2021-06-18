require 'rails_helper'

RSpec.describe BoletoMethod, type: :model do
  it { should validate_presence_of(:bank_code) }
  it { should validate_presence_of(:agency_number) }
  it { should validate_presence_of(:bank_account) }

  it { should validate_numericality_of(:bank_code).is_greater_than_or_equal_to(0) }
  it { should validate_numericality_of(:agency_number).is_greater_than_or_equal_to(0) }
  it { should validate_numericality_of(:bank_account).is_greater_than_or_equal_to(0) }
  it { should validate_length_of(:bank_code).is_equal_to(3) }
  it { should validate_length_of(:agency_number).is_equal_to(4) }

  context 'validating uniqueness' do
    it 'successfully' do
      pay_method = PaymentMethod.create!(name: 'Boleto do banco laranja', tax_porcentage: 5,
                                         tax_maximum: 80, status: true, payment_type: :boleto)
    
      company = Company.create!(name: 'Codeplay', cnpj: '12365478910111',
                                financial_adress: 'Rua Joãozinho',
                                financial_email: 'faturamento@codeplay.com.br',
                                token: SecureRandom.base58(20))
      
      BoletoMethod.create!(bank_code: '341', agency_number: '0123', bank_account: '12233322',
                           company: company, payment_method: pay_method)
      
      User.create!(email: 'baden@codeplay.com.br', password: '012345', 
                   role: 10, company: company)
  
      should validate_uniqueness_of(:agency_number).case_insensitive
      should validate_uniqueness_of(:bank_account).case_insensitive
    end
  end
end
