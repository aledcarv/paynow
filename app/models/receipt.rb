class Receipt < ApplicationRecord
  before_create :auth_code
  belongs_to :charge

  private

    def auth_code
      self.authorization_code = SecureRandom.base58(20)
    
      auth_code if Receipt.where(authorization_code: authorization_code).exists?
    end
end
