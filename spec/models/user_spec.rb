require 'rails_helper'

RSpec.describe User, type: :model do
  it { should allow_value('cartola@codeplay.com.br').for(:email) }
  it { should_not allow_value('gonzaga@gmail.com.br').for(:email).with_message('não é válido') }
  it { should_not allow_value('gonzaga@hotmail.com.br').for(:email).with_message('não é válido') }
  it { should_not allow_value('gonzaga@yahoo.com.br').for(:email).with_message('não é válido') }
  it { should_not allow_value('gonzaga@paynow.com.br').for(:email).with_message('não é válido') }
end
