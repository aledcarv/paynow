require 'rails_helper'

describe 'user view payment method selected' do
    context 'boleto' do
        it 'successfully' do
            pay_method = PaymentMethod.create!(name: 'Boleto do banco laranja', tax_porcentage: 5,
                                               tax_maximum: 80, status: true, payment_type: :boleto)
    
            company = Company.create!(name: 'Codeplay', cnpj: '12365478910111',
                                      financial_adress: 'Rua Joãozinho',
                                      financial_email: 'faturamento@codeplay.com.br',
                                      token: SecureRandom.base58(20))
    
            BoletoMethod.create!(bank_code: '341', agency_number: '0123', bank_account: '12233322',
                                 company: company, payment_method: pay_method)
            
            user = User.create!(email: 'baden@codeplay.com.br', password: '012345',
                                role: 10, company: company)
    
            login_as user, scope: :user
    
            visit root_path
            click_on 'Minha empresa'
    
            expect(page).to have_content('Boleto do banco laranja')
            expect(page).to have_content('341')
            expect(page).to have_content('0123')
            expect(page).to have_content('12233322')
        end
    
        it 'and there is no payment method boleto selected' do
            pay_method = PaymentMethod.create!(name: 'Boleto do banco laranja', tax_porcentage: 5,
                tax_maximum: 80, status: true, payment_type: :boleto)
    
            company = Company.create!(name: 'Codeplay', cnpj: '12365478910111',
                                      financial_adress: 'Rua Joãozinho',
                                      financial_email: 'faturamento@codeplay.com.br',
                                      token: SecureRandom.base58(20))
    
            user = User.create!(email: 'baden@codeplay.com.br', password: '012345',
                                role: 10, company: company)
    
            login_as user, scope: :user
    
            visit root_path
            click_on 'Minha empresa'
    
            expect(page).to have_content('Nenhum meio de pagamento boleto selecionado')
        end
    end

    context 'pix' do
        it 'successfully' do
            pay_method = PaymentMethod.create!(name: 'Pix do banco roxinho', tax_porcentage: 10,
                                               tax_maximum: 150, status: true, payment_type: :pix)
    
            company = Company.create!(name: 'Codeplay', cnpj: '12365478910111',
                                      financial_adress: 'Rua Joãozinho',
                                      financial_email: 'faturamento@codeplay.com.br',
                                      token: SecureRandom.base58(20))
    
            PixMethod.create!(bank_code: '341', key_pix: 'AB120kdjND76RVJJ22l0',
                              company: company, payment_method: pay_method)
            
            user = User.create!(email: 'baden@codeplay.com.br', password: '012345',
                                role: 10, company: company)
    
            login_as user, scope: :user
    
            visit root_path
            click_on 'Minha empresa'
    
            expect(page).to have_content('Pix do banco roxinho')
            expect(page).to have_content('341')
            expect(page).to have_content('AB120kdjND76RVJJ22l0')
        end
    
        it 'and there is no payment method pix selected' do
            pay_method = PaymentMethod.create!(name: 'Pix do banco roxinho', tax_porcentage: 10,
                                               tax_maximum: 150, status: true, payment_type: :pix)
    
            company = Company.create!(name: 'Codeplay', cnpj: '12365478910111',
                                      financial_adress: 'Rua Joãozinho',
                                      financial_email: 'faturamento@codeplay.com.br',
                                      token: SecureRandom.base58(20))
    
            user = User.create!(email: 'baden@codeplay.com.br', password: '012345',
                                role: 10, company: company)
    
            login_as user, scope: :user
    
            visit root_path
            click_on 'Minha empresa'
    
            expect(page).to have_content('Nenhum meio de pagamento pix selecionado')
        end
    end

    context 'card' do
        it 'successfully' do
            pay_method = PaymentMethod.create!(name: 'Cartão MestreCard', tax_porcentage: 6,
                                               tax_maximum: 100, status: true, payment_type: :card)
    
            company = Company.create!(name: 'Codeplay', cnpj: '12365478910111',
                                      financial_adress: 'Rua Joãozinho',
                                      financial_email: 'faturamento@codeplay.com.br',
                                      token: SecureRandom.base58(20))
    
            CardMethod.create!(card_code: '1G0341AB09c8dkwm734m', company: company, 
                               payment_method: pay_method)
            
            user = User.create!(email: 'baden@codeplay.com.br', password: '012345',
                                role: 10, company: company)
    
            login_as user, scope: :user
    
            visit root_path
            click_on 'Minha empresa'
    
            expect(page).to have_content('Cartão MestreCard')
            expect(page).to have_content('1G0341AB09c8dkwm734m')
        end
    
        it 'and there is no payment method boleto selected' do
            pay_method = PaymentMethod.create!(name: 'Cartão MestreCard', tax_porcentage: 6,
                                               tax_maximum: 100, status: true, payment_type: :card)
    
            company = Company.create!(name: 'Codeplay', cnpj: '12365478910111',
                                      financial_adress: 'Rua Joãozinho',
                                      financial_email: 'faturamento@codeplay.com.br',
                                      token: SecureRandom.base58(20))
    
            user = User.create!(email: 'baden@codeplay.com.br', password: '012345',
                                role: 10, company: company)
    
            login_as user, scope: :user
    
            visit root_path
            click_on 'Minha empresa'
    
            expect(page).to have_content('Nenhum meio de pagamento cartão selecionado')
        end
    end
end