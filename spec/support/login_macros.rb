def admin_login
    admin = Admin.create!(email: 'gonzaga@paynow.com.br', password: '012345')

    login_as admin, scope: :admin
end