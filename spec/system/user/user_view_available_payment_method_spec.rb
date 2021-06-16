require 'rails_helper'

describe 'user view avaoçabçe payment methods' do
    it 'successfully' do
        PaymentMethod.create!(name: 'Boleto do banco laranja', tax_porcentage: 5,
                              tax_maximum: 80, status: true, payment_type: :boleto)
        
        PaymentMethod.create!(name: 'Cartão de crédito MestreCard', tax_porcentage: 10,
                              tax_maximum: 95, status: true, payment_type: :card)
        
        PaymentMethod.create!(name: 'Cartão de crédito PISA', tax_porcentage: 15,
                              tax_maximum: 155, status: false, payment_type: :pix)

        user_admin_login
        visit root_path
        click_on 'Meios de pagamento'

        expect(page).to have_content('Boleto do banco laranja')
        expect(page).to have_content('Cartão de crédito MestreCard')
        expect(page).to_not have_content('Cartão de crédito PISA')
    end
    
    it 'and there is no payment method available' do
        PaymentMethod.create!(name: 'Cartão de crédito MestreCard', tax_porcentage: 10,
                              tax_maximum: 95, status: false, payment_type: :card)

        user_admin_login
        visit root_path
        click_on 'Meios de pagamento'

        expect(page).to have_content('Nenhum meio de pagamento disponível')
    end

    it 'and view detail' do
        PaymentMethod.create!(name: 'Cartão de crédito MestreCard', tax_porcentage: 10,
                              tax_maximum: 95, status: true, payment_type: :card)

        user_admin_login
        visit root_path
        click_on 'Meios de pagamento'
        click_on 'Cartão de crédito MestreCard'

        expect(page).to have_content('Cartão de crédito MestreCard')
        expect(page).to have_content('10,0%')
        expect(page).to have_content('R$ 95,00')
        expect(page).to have_content('Ativo')
        expect(page).to have_css('img[src*="cartao.png"]')
    end

    it 'and return to payment method page' do
        PaymentMethod.create!(name: 'Cartão de crédito MestreCard', tax_porcentage: 10,
                              tax_maximum: 95, status: true, payment_type: :card)

        user_admin_login
        visit root_path
        click_on 'Meios de pagamento'
        click_on 'Cartão de crédito MestreCard'
        click_on 'Voltar'

        expect(current_path).to eq(user_payment_methods_path)
    end

    it 'and must be logged in to access route' do
        visit user_payment_methods_path

        expect(current_path).to eq(new_user_session_path)
    end

    it 'and must be logged in to access show route' do
        pay_method = PaymentMethod.create!(name: 'Cartão de crédito MestreCard', tax_porcentage: 10,
                                          tax_maximum: 95, status: true, payment_type: :card)
        
        visit user_payment_method_path(pay_method)

        expect(current_path).to eq(new_user_session_path)
    end
end