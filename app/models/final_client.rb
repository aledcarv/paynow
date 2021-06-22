class FinalClient < ApplicationRecord
    before_create :token_generator

    has_many :final_client_companies
    has_many :companies, through: :final_client_companies

    validates :name, :cpf, presence: true
    validates :cpf, uniqueness: true

    private

        def token_generator
            self.token = SecureRandom.base58(20)
            token_generator if Company.where(token: token).exists?
        end
end
