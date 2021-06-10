require 'rails_helper'

RSpec.describe PaymentMethod, type: :model do
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:tax_porcentage) }
  it { should validate_presence_of(:tax_maximum) }
end

describe 'name uniqueness' do
  subject { PaymentMethod.new(name: 'Boleto do banco laranja', tax_porcentage: 5,
                              tax_maximum: 80, status: true, payment_type: :boleto) }
  it { should validate_uniqueness_of(:name).case_insensitive }
end