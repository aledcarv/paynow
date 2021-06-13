class Company < ApplicationRecord
    validates :name, :cnpj, :financial_adress, :financial_email, presence: true
    validates :name, :cnpj, :financial_adress, :financial_email, uniqueness: true
    validates :cnpj, length: { is: 14 }
end
