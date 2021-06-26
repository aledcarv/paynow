class Charge < ApplicationRecord
    before_create :token_generator
    before_create :due_date_payment

    validates :original_value, :discount_value, 
              :final_client_name, :final_client_cpf,
              :company_token, :product_token, :payment_method, :status, presence: true

    enum status: { pendente: 1, aprovado: 2 }

    has_many :receipts

    private 
      
      def token_generator
          self.token = SecureRandom.base58(20)
    
          token_generator if Charge.where(token: token).exists?
      end

      def due_date_payment
        self.due_date = 1.week.from_now
      end
end
