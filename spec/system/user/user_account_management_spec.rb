require 'rails_helper'

describe 'user account management' do
    context 'register' do
        it 'successfully' do
            visit root_path
            click_on 'Registrar-me'

            fill_in 'Email', with: 'cartola@codeplay.com.br'
            fill_in 'Senha', with: '012345'
            fill_in 'Confirmação de senha', with: '012345'
            click_on 'Criar conta'

            expect(current_path).to eq(root_path)
            expect(page).to have_content('Login efetuado com sucesso')
            expect(page).to have_content('cartola@codeplay.com.br')
            expect(page).to have_content('Sair')
        end

        it 'and attributes can not be blank' do
            visit root_path
            click_on 'Registrar-me'

            fill_in 'Email', with: ''
            fill_in 'Senha', with: ''
            fill_in 'Confirmação de senha', with: ''
            click_on 'Criar conta'

            expect(page).to have_content('não pode ficar em branco', count: 2)
        end

        it 'and email can not be invalid' do
            visit root_path
            click_on 'Registrar-me'

            fill_in 'Email', with: 'cartola@gmail.com'
            fill_in 'Senha', with: '012345'
            fill_in 'Confirmação de senha', with: '012345'

            click_on 'Criar conta'

            expect(page).to have_content('não é válido')
        end

        it 'and password confirmation is different' do
            visit root_path
            click_on 'Registrar-me'

            fill_in 'Email', with: 'cartola@codeplay.com.br'
            fill_in 'Senha', with: '012345'
            fill_in 'Confirmação de senha', with: '123456'
            click_on 'Criar conta'

            expect(page).to have_content('não é igual a Senha')
        end

        it 'and email must be unique' do
            User.create!(email: 'cartola@codeplay.com.br', password: '012345')

            visit root_path
            click_on 'Registrar-me'

            fill_in 'Email', with: 'cartola@codeplay.com.br'
            fill_in 'Senha', with: '012345'
            fill_in 'Confirmação de senha', with: '012345'
            click_on 'Criar conta'

            expect(page).to have_content('já está em uso')
        end
    end

    context 'login' do
        it 'successfully' do
            User.create!(email: 'cartola@codeplay.com.br', password: '012345')
    
            visit new_user_session_path
            fill_in 'Email', with: 'cartola@codeplay.com.br'
            fill_in 'Senha', with: '012345'
            within 'form' do
                click_on 'Entrar'
            end
    
            expect(current_path).to eq(root_path)
            expect(page).to have_content('cartola@codeplay.com.br')
            expect(page).to have_content('Sair')
        end
    
        it 'and uses wrong login information' do
            User.create!(email: 'cartola@codeplay.com.br', password: '012345')
    
            visit new_user_session_path
            fill_in 'Email', with: 'cartola@codeplay.com.br'
            fill_in 'Senha', with: '123456'
            within 'form' do
                click_on 'Entrar'
            end
    
            expect(current_path).to eq(new_user_session_path)
            expect(page).to have_content('Email ou senha inválida.')
        end
    end

    context 'log out' do
        it 'sucessfully' do
            user_login
            visit root_path
            click_on 'Sair'
    
            expect(current_path).to eq(root_path)
            expect(page).to have_content('Saiu com sucesso')
            expect(page).to_not have_content('cartola@codeplay.com.br')
            expect(page).to_not have_link('Sair', href: destroy_user_session_path)
            expect(page).to have_link('Entrar', href: new_user_session_path)
        end
    end

    context 'forgot password' do
        it 'and receives instruction to reset password' do
            User.create(email: 'cartola@codeplay.com.br', password: '012345')

            visit new_user_session_path
            click_on 'Esqueceu sua senha?'
            fill_in 'Email', with: 'cartola@codeplay.com.br'
            click_on 'Envie-me instruções para reformular a senha'

            expect(current_path).to eq(new_user_session_path)
            expect(page).to have_content('Dentro de minutos, você receberá um e-mail com instruções para a troca da sua senha.')
        end

        it 'and resets password' do
            user = User.create!(email: 'cartola@codeplay.com.br', password: '012345')
            token = user.send_reset_password_instructions

            visit edit_user_password_path(reset_password_token: token)
            fill_in 'Nova senha', with: '123456'
            fill_in 'Confirmar nova senha', with: '123456'
            click_on 'Mudar minha senha'

            expect(current_path).to eq(root_path)
            expect(page).to have_content('Sua senha foi alterada com sucesso. Você está logado.')
        end
    end
end