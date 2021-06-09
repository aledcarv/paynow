require 'rails_helper'

RSpec.describe PaymentMethod, type: :model do
  it { should validate_uniqueness_of(:name) }
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:tax_porcentage) }
  it { should validate_presence_of(:tax_maximum) }
end
