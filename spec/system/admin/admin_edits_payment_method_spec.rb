require 'rails_helper'

describe 'admin edits payment method' do
    it 'successfully' do
        pay_method = PaymentMethod.create!(name: 'Boleto do banco laranja', tax_porcentage: 10, 
                                           tax_maximum: 100, status: true)

        admin_login
        visit root_path
        click_on 'Meios de pagamento'
        click_on 'Boleto do banco laranja'
        click_on 'Editar meio de pagamento'

        fill_in 'Nome', with: 'Boleto do banco roxo'
        fill_in 'Taxa de cobrança', with: 5
        fill_in 'Taxa máxima', with: 90
        select 'Inativo', from: 'Status'
        click_on 'Editar'

        expect(current_path).to eq(admin_payment_method_path(pay_method))
        expect(page).to have_content('Boleto do banco roxo')
        expect(page).to have_content('5,0%')
        expect(page).to have_content('R$ 90,00')
        expect(page).to have_content('Inativo')
    end

    it 'and can not be blank' do
        PaymentMethod.create!(name: 'Boleto do banco laranja', tax_porcentage: 10,
                              tax_maximum: 100, status: true)

        admin_login
        visit root_path
        click_on 'Meios de pagamento'
        click_on 'Boleto do banco laranja'
        click_on 'Editar meio de pagamento'

        fill_in 'Nome', with: ''
        fill_in 'Taxa de cobrança', with: ''
        fill_in 'Taxa máxima', with: ''
        click_on 'Editar'

        expect(page).to have_content('não pode ficar em branco', count: 3)
    end

    it 'and name must be unique' do
        PaymentMethod.create!(name: 'Boleto do banco laranja', tax_porcentage: 10,
                              tax_maximum: 100, status: true)
        PaymentMethod.create!(name: 'Boleto do banco roxo', tax_porcentage: 5,
                              tax_maximum: 80, status: true)

        admin_login
        visit root_path
        click_on 'Meios de pagamento'
        click_on 'Boleto do banco laranja'
        click_on 'Editar meio de pagamento'

        fill_in 'Nome', with: 'Boleto do banco roxo'
        click_on 'Editar'

        expect(page).to have_content('já está em uso')
    end
end