def admin_login
    admin = Admin.create!(email: 'gonzaga@paynow.com.br', password: '012345')

    login_as admin, scope: :admin
end

def user_login
    user = User.create!(email: 'cartola@codeplay.com.br', password: '012345', role: 0)
    
    login_as user, scope: :user
end