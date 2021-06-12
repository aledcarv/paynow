require 'rails_helper'

describe 'admin deletes payment method' do
    it 'successfully' do
        PaymentMethod.create!(name: 'Boleto do banco laranja', tax_porcentage: 10, 
                              tax_maximum: 100, status: true, payment_type: :boleto)

        admin_login
        visit root_path
        click_on 'Meios de pagamento'
        click_on 'Boleto do banco laranja'

        expect { click_on 'Apagar meio de pagamento' }.to change { PaymentMethod.count }.by(-1)

        expect(current_path).to eq(admin_payment_methods_path)
        expect(page).to have_content('Meio de pagamento apagado com sucesso')
    end
end