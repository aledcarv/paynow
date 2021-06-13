require 'rails_helper'

describe 'admin management account' do
    context 'log in' do
        it 'successfully' do
            Admin.create!(email: 'gonzaga@paynow.com.br', password: '012345')
    
            visit new_admin_session_path
            fill_in 'Email', with: 'gonzaga@paynow.com.br'
            fill_in 'Senha', with: '012345'
            within 'form' do
                click_on 'Entrar'
            end
    
            expect(current_path).to eq(root_path)
            expect(page).to have_content('gonzaga@paynow.com.br')
            expect(page).to have_link('Sair', href: destroy_admin_session_path)
        end
    
        it 'and uses wrong login information' do
            Admin.create!(email: 'gonzaga@paynow.com.br', password: '012345')
    
            visit new_admin_session_path
            fill_in 'Email', with: 'gonzaga@paynow.com.br'
            fill_in 'Senha', with: '123456'
            within 'form' do
                click_on 'Entrar'
            end
    
            expect(current_path).to eq(new_admin_session_path)
            expect(page).to have_content('Email ou senha inválida.')
        end
    end

    context 'log out' do
        it 'successfully' do
            admin_login
            visit root_path
            click_on 'Sair'
    
            expect(current_path).to eq(root_path)
            expect(page).to have_content('Saiu com sucesso')
            expect(page).to_not have_content('gonzaga@paynow.com.br')
            expect(page).to_not have_link('Sair', href: destroy_admin_session_path)
        end
    end

    context 'forgot password' do
        it 'and receive instructions to reset password' do
            Admin.create(email: 'gonzaga@paynow.com.br', password: '012345')

            visit new_admin_session_path
            click_on 'Esqueceu sua senha?'
            fill_in 'Email', with: 'gonzaga@paynow.com.br'
            click_on 'Envie-me instruções para reformular a senha'

            expect(current_path).to eq(new_admin_session_path)
            expect(page).to have_content('Dentro de minutos, você receberá um e-mail com instruções para a troca da sua senha.')
        end

        it 'and resets password' do
            admin = Admin.create!(email: 'gonzaga@paynow.com.br', password: '012345')
            token = admin.send_reset_password_instructions

            visit edit_admin_password_path(reset_password_token: token)
            fill_in 'Nova senha', with: '123456'
            fill_in 'Confirmar nova senha', with: '123456'
            click_on 'Mudar minha senha'

            expect(current_path).to eq(root_path)
            expect(page).to have_content('Sua senha foi alterada com sucesso. Você está logado.')
        end
    end
end 