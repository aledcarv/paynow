class Company < ApplicationRecord
    validates :name, :cnpj, :financial_adress, :financial_email, presence: true
    validates :name, :cnpj, :financial_adress, :financial_email, uniqueness: true
    validates :cnpj, length: { is: 14 }
    
    before_create :token_generator
    
    has_many :users
    has_many :boleto_methods

    private

        def token_generator
            self.token = SecureRandom.base58(20)
            token_generator if Company.where(token: token).exists?
        end
end
