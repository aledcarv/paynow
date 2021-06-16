def admin_login
    admin = Admin.create!(email: 'gonzaga@paynow.com.br', password: '012345')

    login_as admin, scope: :admin
end

def user_login
    user = User.create!(email: 'cartola@codeplay.com.br', password: '012345', role: 0)
    
    login_as user, scope: :user
end

def user_admin_login
    company = Company.create!(name: 'Codeplay', cnpj: '12365478910111', 
                              financial_adress: 'Rua Joãozinho', 
                              financial_email: 'faturamento@codeplay.com.br',
                              token: SecureRandom.base58(20))
    
    user = User.create(email: 'baden@codeplay.com.br', password: '012345', 
                       role: 10, company_id: company.id)
    
    login_as user, scope: :user
end