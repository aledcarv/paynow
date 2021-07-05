
# Descrição

A Paynow é uma plataforma de pagamento criada para que empresas possam decidir, dentre os meios de pagamento disponíveis, quais serão utilizados em suas vendagens e, a partir disso, gerar cobranças destinadas aos seus próprios clientes.

## Gems usadas no projeto


- [Rspec](https://github.com/rspec/rspec-rails)
- [Capybara](https://github.com/teamcapybara/capybara)
- [Shoulda Matchers](https://github.com/thoughtbot/shoulda-matchers)
- [Devise](https://github.com/heartcombo/devise)


  
## Como rodar o projeto

Para rodar o projeto, é necessário ter instalado o `Ruby (3.0.0)` e o `Ruby on Rails (6.1.3.2)`.

Clone o projeto

```bash
  git clone https://github.com/aledcarv/paynow.git
```

Vá para o diretório do projeto

```bash
  cd paynow
```

Instale as dependências

```bash
  bin/setup
```

Para popular o banco com dados já existentes, digite

```bash
  rails db:seed
```

Inicie o servidor

```bash
  rails s
```

Digite no seu navegador

```bash
  http://127.0.0.1:3000
```
  
## Como rodar os testes

Para rodar os testes, insira o seguinte comando

```bash
  rspec
```

# Observação

- O cadastro na Paynow deve ser feito via console, utilizando o domínio `@paynow.com.br`
- Acesse `http://127.0.0.1:3000/admins/sign_in` para logar como admin

## Navegação

- Para acessar como admin a partir de uma conta já definida, utilize o email `admin@paynow.com.br` e a senha `012345`
- Para acessar como cliente a partir de uma conta já definida, utilize o email `user@codeplay.com.br` e a senha `123456`

# API

## Registro do cliente final

-  Este endpoint recebe as informações do cliente de uma determinada empresa cadastrada na Paynow

POST '/api/v1/final_clients'

```bash
  {
    "final_client": {
      "name": "Nome do cliente final"
      "cpf": "Cpf do cliente final"
    },
    "company_token": "token da empresa cliente"
  }
```
- Se os dados estiverem distribuidos de forma correta, a requisição retorna um `status 201` e o cliente é registrado
- HTTP Status 422: caso algum parâmetro esteja inválido ou ausente

## Emissão de cobranças

- Este endpoint é utilizado para emitir as cobranças de uma determinada empresa cadastrada na Paynow.

POST '/api/v1/charges'

- Para boleto

```bash
  {
    "charge": {
      "company_token": "token da empresa cliente",
      "product_token": "token do produto",
      "payment_method": "token do método de pagamento",
      "final_client_name": "nome do cliente final",
      "final_client_cpf": "cpf do cliente final", 
      "address": "endereço do cliente final"
    }
  }
```

- Para Cartão de crédito

```bash
  {
    "charge": {
      "company_token": "token da empresa cliente",
      "product_token": "token do produto",
      "payment_method": "token do método de pagamento",
      "final_client_name": "nome do cliente final",
      "final_client_cpf": "cpf do cliente final", 
      "card_number": "Número do cartão de crédito",
      "card_printed_name": "Nome impresso no cartão de crédito",
      "verification_code": "Código de verificação"
    }
  }
```

- Para PIX

```bash
  {
    "charge": {
      "company_token": "token da empresa cliente",
      "product_token": "token do produto",
      "payment_method": "token do método de pagamento",
      "final_client_name": "nome do cliente final",
      "final_client_cpf": "cpf do cliente final", 
    }
  }
```

- Se os dados estiverem distribuidos de forma correta, a requisição retorna um `status 201`
- HTTP Status 422: caso algum parâmetro esteja inválido ou ausente