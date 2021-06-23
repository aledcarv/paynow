require 'rails_helper'

describe 'charge API' do
    context 'POST /api/v1/charges' do
        it 'and should create new charge with boleto' do
            company = Company.create!(name: 'Codeplay', cnpj: '12365478910111',
                                      financial_adress: 'Rua Joãozinho',
                                      financial_email: 'faturamento@codeplay.com.br')
                                      
            product = Product.create!(name: 'Curso de Ruby', price: 30, boleto_discount: 5, 
                                      pix_discount: 0, card_discount: 4, company: company)

            pay_method = PaymentMethod.new(name: 'Boleto do banco laranja', tax_porcentage: 5,
                                           tax_maximum: 80, status: true, payment_type: :boleto)

            final_client = FinalClient.create!(name: 'Pedro Alberto', cpf: '12345678960')

            post '/api/v1/charges', params: {
                charge: {
                    company_token: company.token,
                    product_token: product.token,
                    payment_method: pay_method.payment_type,
                    final_client_name: final_client.name,
                    final_client_cpf: final_client.cpf, 
                    address: 'Rua Oliveira, n° 133'
                }
            }

            expect(response).to have_http_status(201)
            expect(response.content_type).to include('application/json')
            parsed_body = JSON.parse(response.body)
            expect(parsed_body['original_value']).to include('30.0')
            expect(parsed_body['discount_value']).to include('28.5')
            expect(parsed_body['final_client_name']).to include('Pedro Alberto')
            expect(parsed_body['final_client_cpf']).to include('12345678960')
            expect(parsed_body['address']).to include('Rua Oliveira, n° 133')
        end

        it 'and should create new charge with card' do
            company = Company.create!(name: 'Codeplay', cnpj: '12365478910111',
                                      financial_adress: 'Rua Joãozinho',
                                      financial_email: 'faturamento@codeplay.com.br')
                                      
            product = Product.create!(name: 'Curso de Ruby', price: 30, boleto_discount: 5, 
                                      pix_discount: 2, card_discount: 4, company: company)

            pay_method = PaymentMethod.new(name: 'Boleto do banco laranja', tax_porcentage: 5,
                                           tax_maximum: 80, status: true, payment_type: :card)

            final_client = FinalClient.create!(name: 'Pedro Alberto', cpf: '12345678960')

            post '/api/v1/charges', params: {
                charge: {
                    company_token: company.token,
                    product_token: product.token,
                    payment_method: pay_method.payment_type,
                    final_client_name: final_client.name,
                    final_client_cpf: final_client.cpf, 
                    card_number: '0123654678034123',
                    card_printed_name: 'Pedro Alberto',
                    verification_code: '123'
                }
            }

            expect(response).to have_http_status(201)
            expect(response.content_type).to include('application/json')
            parsed_body = JSON.parse(response.body)
            expect(parsed_body['original_value']).to include('30.0')
            expect(parsed_body['discount_value']).to include('28.8')
            expect(parsed_body['final_client_name']).to include('Pedro Alberto')
            expect(parsed_body['final_client_cpf']).to include('12345678960')
            expect(parsed_body['card_number']).to include('0123654678034123')
            expect(parsed_body['card_printed_name']).to include('Pedro Alberto')
            expect(parsed_body['card_number']).to include('123')

        end

        it 'and should create new charge with pix' do
            company = Company.create!(name: 'Codeplay', cnpj: '12365478910111',
                                      financial_adress: 'Rua Joãozinho',
                                      financial_email: 'faturamento@codeplay.com.br')
                                      
            product = Product.create!(name: 'Curso de Ruby', price: 30, boleto_discount: 5, 
                                      pix_discount: 2, card_discount: 4, company: company)

            pay_method = PaymentMethod.new(name: 'Boleto do banco laranja', tax_porcentage: 5,
                                           tax_maximum: 80, status: true, payment_type: :pix)

            final_client = FinalClient.create!(name: 'Pedro Alberto', cpf: '12345678960')

            post '/api/v1/charges', params: {
                charge: {
                    company_token: company.token,
                    product_token: product.token,
                    payment_method: pay_method.payment_type,
                    final_client_name: final_client.name,
                    final_client_cpf: final_client.cpf, 
                }
            }

            expect(response).to have_http_status(201)
            expect(response.content_type).to include('application/json')
            parsed_body = JSON.parse(response.body)
            expect(parsed_body['original_value']).to include('30.0')
            expect(parsed_body['discount_value']).to include('29.4')
            expect(parsed_body['final_client_name']).to include('Pedro Alberto')
            expect(parsed_body['final_client_cpf']).to include('12345678960')
        end

        it 'and no final client name and cpf' do
            company = Company.create!(name: 'Codeplay', cnpj: '12365478910111',
                                      financial_adress: 'Rua Joãozinho',
                                      financial_email: 'faturamento@codeplay.com.br')
                                      
            product = Product.create!(name: 'Curso de Ruby', price: 30, boleto_discount: 5, 
                                      pix_discount: 0, card_discount: 4, company: company)

            pay_method = PaymentMethod.new(name: 'Boleto do banco laranja', tax_porcentage: 5,
                                           tax_maximum: 80, status: true, payment_type: :boleto)

            final_client = FinalClient.create!(name: 'Pedro Alberto', cpf: '12345678960')

            post '/api/v1/charges', params: {
                charge: {
                    company_token: company.token,
                    product_token: product.token,
                    payment_method: pay_method.payment_type,
                    final_client_name: '',
                    final_client_cpf: ''
                }
            }

            expect(response).to have_http_status(422)
            expect(response.content_type).to include('application/json')
            parsed_body = JSON.parse(response.body)
            expect(parsed_body['final_client_name']).to include('não pode ficar em branco')
            expect(parsed_body['final_client_cpf']).to include('não pode ficar em branco')
        end
    end
end