require 'rails_helper'

RSpec.describe Charge, type: :model do
  it { should validate_presence_of(:original_value) }
  it { should validate_presence_of(:discount_value) }
  it { should validate_presence_of(:final_client_name) }
  it { should validate_presence_of(:final_client_cpf) }
  it { should validate_presence_of(:company_token) }
  it { should validate_presence_of(:product_token) }
  it { should validate_presence_of(:payment_method) }
  it { should validate_presence_of(:status) }
end
