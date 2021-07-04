
# Descrição

A Paynow é um site criado para que empresas possam decidir quais meios de pagamento serão utilizados em suas vendagens e, a partir disso, gerar cobranças.

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
