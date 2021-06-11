require 'rails_helper'

describe 'admin view payment method' do
    it 'successfully' do
        PaymentMethod.create!(name: 'Boleto do banco laranja', tax_porcentage: 5,
                              tax_maximum: 80, status: true, payment_type: :boleto)
        PaymentMethod.create!(name: 'Cartão de crédito MestreCard', tax_porcentage: 10,
                              tax_maximum: 95, status: false, payment_type: :card)
        
        admin_login
        visit root_path
        click_on 'Meios de pagamentos'

        expect(current_path).to eq(admin_payment_methods_path)
        expect(page).to have_content('Meios de pagamento')
        expect(page).to have_content('Boleto do banco laranja')
        expect(page).to have_content('5,0%')
        expect(page).to have_content('R$ 80,00')
        expect(page).to have_content('Cartão de crédito MestreCard')
        expect(page).to have_content('10,0%')
        expect(page).to have_content('R$ 95,00')
    end

    it 'and there is no payment method' do
        admin_login
        visit root_path
        click_on 'Meios de pagamentos'
        
        expect(page).to have_content('Nenhum meio de pagamento disponível')
    end

    it 'and view detail' do
        PaymentMethod.create!(name: 'Boleto do banco laranja', tax_porcentage: 5,
                              tax_maximum: 80, status: true, payment_type: :boleto)
        admin_login
        visit root_path
        click_on 'Meios de pagamento'
        click_on 'Boleto do banco laranja'

        expect(page).to have_content('Boleto do banco laranja')
        expect(page).to have_content('5,0%')
        expect(page).to have_content('R$ 80,00')
        expect(page).to have_content('Ativo')
        expect(page).to have_css('img[src*="boleto.png"]')
    end

    it 'and return to payment methods page' do
        PaymentMethod.create!(name: 'Boleto do banco laranja', tax_porcentage: 5,
                              tax_maximum: 80, status: true, payment_type: :boleto)

        admin_login
        visit root_path
        click_on 'Meios de pagamento'
        click_on 'Boleto do banco laranja'
        click_on 'Voltar'

        expect(current_path).to eq(admin_payment_methods_path)
    end
end