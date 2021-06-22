class Company < ApplicationRecord
    validates :name, :cnpj, :financial_adress, :financial_email, presence: true
    validates :name, :cnpj, :financial_adress, :financial_email, uniqueness: true
    validates :cnpj, length: { is: 14 }
    
    before_create :token_generator
    
    has_many :users
    has_many :boleto_methods
    has_many :pix_methods
    has_many :card_methods
    has_many :products
    has_many :final_client_companies
    has_many :final_clients, through: :final_client_companies

    private

        def token_generator
            self.token = SecureRandom.base58(20)
            token_generator if Company.where(token: token).exists?
        end
end
