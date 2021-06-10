require 'rails_helper'

describe 'admin creates payment method' do
    it 'successfully' do
        admin_login
        visit root_path
        click_on 'Meios de pagamento'
        click_on 'Cadastrar um meio de pagamento'

        fill_in 'Nome', with: 'Cartão do banco roxinho'
        fill_in 'Taxa de cobrança', with: 15
        fill_in 'Taxa máxima', with: 120
        select 'Ativo', from: 'Status'
        select 'cartão', from: 'Tipos de pagamento'
        click_on 'Cadastrar'

        expect(current_path).to eq(admin_payment_method_path(PaymentMethod.last))
        expect(page).to have_content('Cartão do banco roxinho')
        expect(page).to have_content('15,0%')
        expect(page).to have_content('R$ 120,00')
        expect(page).to have_content('Ativo')
    end

    it 'and can not be blank' do
        admin_login
        visit root_path
        click_on 'Meios de pagamento'
        click_on 'Cadastrar um meio de pagamento'

        fill_in 'Nome', with: ''
        fill_in 'Taxa de cobrança', with: ''
        fill_in 'Taxa máxima', with: ''
        select 'escolha', from: 'Tipos de pagamento'
        click_on 'Cadastrar'

        expect(page).to have_content('não pode ficar em branco', count: 4)
    end

    it 'and name must be unique' do
        PaymentMethod.create!(name: 'Cartão do banco laranja', tax_porcentage: 5,
                              tax_maximum: 80, status: true, payment_type: :card)

        admin_login
        visit root_path
        click_on 'Meios de pagamento'
        click_on 'Cadastrar um meio de pagamento'

        fill_in 'Nome', with: 'Cartão do banco laranja'
        fill_in 'Taxa de cobrança', with: 10
        fill_in 'Taxa máxima', with: 90
        select 'Inativo', from: 'Status'
        click_on 'Cadastrar'

        expect(page).to have_content('já está em uso')
    end
end