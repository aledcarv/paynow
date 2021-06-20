class Product < ApplicationRecord
  validates :name, :price, presence: true
  validates :name, uniqueness: { case_sensitive: false }

  belongs_to :company

  before_create :token_generator

  private

    def token_generator
      self.token = SecureRandom.base58(20)

      token_generator if Company.where(token: token).exists?
    end
end
