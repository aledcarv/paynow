require 'rails_helper'

describe 'final client API' do
    context 'POST /api/v1/final_clients' do
        it 'and should create new final client' do
            company = Company.create!(name: 'Codeplay', cnpj: '12365478910111',
                                      financial_adress: 'Rua Joãozinho',
                                      financial_email: 'faturamento@codeplay.com.br')

            post '/api/v1/final_clients', params: { 
                final_client: { name: 'Pedro Alberto', cpf: '12345678960' },
                company_token: company.token 
            }

            expect(response).to have_http_status(201)
            expect(response.content_type).to include('application/json')
            parsed_body = JSON.parse(response.body)
            expect(parsed_body['name']).to include('Pedro Alberto')
            expect(parsed_body['cpf']).to include('12345678960')
            expect(FinalClient.last.companies).to include(company)
        end

        it 'and final client params should not be blank' do
            company = Company.create!(name: 'Codeplay', cnpj: '12365478910111',
                                      financial_adress: 'Rua Joãozinho',
                                      financial_email: 'faturamento@codeplay.com.br',
                                      token: SecureRandom.base58(20))

            post '/api/v1/final_clients', params: { 
                final_client: { name: '', cpf: '' },
                company_token: company.token 
            }

            expect(response).to have_http_status(422)
            expect(response.content_type).to include('application/json')
            parsed_body = JSON.parse(response.body)
            expect(parsed_body['name']).to include('não pode ficar em branco')
            expect(parsed_body['cpf']).to include('não pode ficar em branco')
        end
        
        it 'and final client params should be unique' do
            company = Company.create!(name: 'Codeplay', cnpj: '12365478910111',
                                      financial_adress: 'Rua Joãozinho',
                                      financial_email: 'faturamento@codeplay.com.br',
                                      token: SecureRandom.base58(20))

            final_client = FinalClient.create!(name: 'Pedro Alberto', cpf: '12345678960')
            FinalClientCompany.create!(company: company, final_client: final_client)

            post '/api/v1/final_clients', params: { 
                final_client: { name: 'Pedro Alberto', cpf: '12345678960' },
                company_token: company.token 
            }

            expect(response).to have_http_status(422)
            expect(response.content_type).to include('application/json')
            expect(response.body).to include('já está em uso')
        end
    end
end