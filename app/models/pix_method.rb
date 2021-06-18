class PixMethod < ApplicationRecord
  belongs_to :company
  belongs_to :payment_method

  validates :bank_code, :key_pix, presence: true
  validates :key_pix, uniqueness: true
  validates :bank_code, length: { is: 3 }
  validates :key_pix, length: { is: 20 }
end
