require 'rails_helper'

RSpec.describe Admin, type: :model do
  it { should allow_value('gonzaga@paynow.com.br').for(:email) }  
  it { should_not allow_value('cartola@hotmail.com').for(:email) }
end
