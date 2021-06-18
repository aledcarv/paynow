class BoletoMethod < ApplicationRecord
  belongs_to :company
  belongs_to :payment_method

  validates :bank_code, :agency_number, :bank_account, presence: true
  validates :agency_number, :bank_account, uniqueness: true
  validates :bank_code, :agency_number, :bank_account, numericality: { greater_than_or_equal_to: 0 }
  validates :bank_code, length: { is: 3 }
  validates :agency_number, length: { is: 4 }
end
