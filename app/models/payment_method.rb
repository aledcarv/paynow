class PaymentMethod < ApplicationRecord
    has_one_attached :icon_payment_type
    validates :name, uniqueness: { case_sensitive: false }
    validates :name, :tax_porcentage, :tax_maximum, :payment_type, presence: true
    enum payment_type: { boleto: 1, card: 2, pix: 3 }
    after_create :attach_icon_pay_type

    scope :available, -> { where(status: true) }

    has_many :boleto_methods
    has_many :pix_methods
    has_many :card_methods

    private

        def attach_icon_pay_type
            if self.boleto?
                icon_payment_type.attach(io: File.open('spec/fixtures/boleto.png'),
                                         filename: 'boleto.png')
            elsif self.card?
                icon_payment_type.attach(io: File.open('spec/fixtures/cartao.png'),
                                         filename: 'cartao.png')
            elsif self.pix?
                icon_payment_type.attach(io: File.open('spec/fixtures/cartao.png'),
                                         filename: 'cartao.png')
            end
        end
end
