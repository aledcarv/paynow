Admin.create!(email: 'admin@paynow.com.br', password: '012345')

boleto_pay_method = PaymentMethod.create!(name: 'Boleto do banco laranja', tax_porcentage: 5,
                                          tax_maximum: 80, status: true, payment_type: :boleto)

pix_pay_method = PaymentMethod.create!(name: 'Pix do banco roxinho', tax_porcentage: 3,
                                       tax_maximum: 60, status: true, payment_type: :pix)

card_pay_method = PaymentMethod.create!(name: 'Cartão MestreCard', tax_porcentage: 10,
                                        tax_maximum: 100, status: true, payment_type: :card)

PaymentMethod.create!(name: 'Cartão PISA', tax_porcentage: 5,
                      tax_maximum: 70, status: false, payment_type: :card)

company = Company.create!(name: 'Codeplay', 
                          cnpj: '12365478910111', financial_adress: 'Rua Joãozinho',
                          financial_email: 'faturamento@codeplay.com.br', token: SecureRandom.base58(20))

User.create!(email: 'user@codeplay.com.br', 
             password: '123456', role: 10, company_id: company.id)

BoletoMethod.create!(bank_code: '341', agency_number: '0123', 
                     bank_account: '12233322', company: company, 
                     payment_method: boleto_pay_method)

PixMethod.create!(bank_code: '341', key_pix: 'AB120kdjND76RVJJ22l0',
                  company: company, payment_method: pix_pay_method)

CardMethod.create!(card_code: '1G0341AB09c8dkwm734m', company: company, 
                   payment_method: card_pay_method)

product = Product.create!(name: 'Curso de Ruby', price: 30, boleto_discount: 5, 
                          pix_discount: 2, card_discount: 4, company: company)

FinalClient.create!(name: 'Pedro Alberto', cpf: '12345678960')

Charge.create!(original_value: 30.0, discount_value: 28.8, token: SecureRandom.base58(20),
               status: :pending, final_client_name: 'Pedro Alberto', final_client_cpf: '12345678960',
               company_token: company.token, product_token: product.token, payment_method: boleto_pay_method.payment_type)