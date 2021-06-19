class CardMethod < ApplicationRecord
  belongs_to :company
  belongs_to :payment_method

  validates :card_code, presence: true
  validates :card_code, length: { is: 20 }
  validates :card_code, uniqueness: true
end
