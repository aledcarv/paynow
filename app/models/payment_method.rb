class PaymentMethod < ApplicationRecord
    validates :name, uniqueness: true
    validates :name, :tax_porcentage, :tax_maximum, presence: true
end
