# Rails Blog

Rails Blog é um projeto com o objetivo de estudar e demonstrar meus conhecimentos em MVC, focando em Ruby on Rails, na forma de um blog.

## Startup

### Bibliotecas

Para instalar todas as bibliotecas do projeto, use `bundle install`

### Banco de dados

Por padrão, o projeto utiliza Sqlite e migrations, então para realizar as migrations, utilize o comando `rails db:migrate`

### Start

Para iniciar o projeto, use `rails server`

## Entidades

- `User`: Entidade do [Devise](https://github.com/heartcombo/devise) para fazer autenticação e autorização, e armazenar dados dos usuários.
    - `username`
    - `email`
    - `password`

- `Article`: Entidade para representar os artigos no blog
    - `title`
    - `body`
    - `views`
    - `user_id` (e `user` pela associação do Rails)

- `Comment`: Entidade para representar os comentários de um artigo
    - `body`
    - `user_id` (e `user` pela associação do Rails)
    - `article_id` (e `article` pela associação do Rails)

## Rotas

Para listar as rotas do projeto, use `rails routes`