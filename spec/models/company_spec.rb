require 'rails_helper'

RSpec.describe Company, type: :model do
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:cnpj) }
  it { should validate_presence_of(:financial_adress) }
  it { should validate_presence_of(:financial_email) }

  it { should validate_uniqueness_of(:name) }
  it { should validate_uniqueness_of(:cnpj) }
  it { should validate_uniqueness_of(:financial_adress) }
  it { should validate_uniqueness_of(:financial_email) }
  it { should validate_length_of(:cnpj).is_equal_to(14) }
end
