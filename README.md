#FARMA

Ferramenta de Autoria para a Remediação de erros com Mobilidade na Aprendizagem.

##Pré-requisitos

```
nodejs
libpq-dev
postgresql
postgresql-contrib

```

##Instalação

1. Clone o repositório do projeto utilizando o comando 

    * `git clone https://dmarczal@bitbucket.org/farma-reborned/farma.git`

2. Instalar as gems necessárias

    * Executar  `gem install bundler`
    * Executar  `bundle install`

3. Configure as váriaveis de ambiente

```
    export GMAIL_USERNAME=username
    export GMAIL_PASSWORD=senha

    export FARMA_DATABASE_USERNAME=username
    export FARMA_DATABASE_PASSWORD=senha
```

4. Crie banco e as tabelas do banco de dados

    * Executar `bundle exec rake db:create`
    * Executar `bundle exec rake db:migrate`

5. Criar as páginas Sobre e Contato

    * Executar o comando `bundle exec rake db:seed`

6. Levante o servidor e acesse a aplicação

    * Execute `thin start`
    * Acesse a [FARMA](http://localhost:3000)

##Documentação

##Suporte

##Contribua

  Para contribuir com o projeto use o sistema de Pull Request

##Contribuidores

##Copyright

  FARMA está cobre a [licença do MIT](http://opensource.org/licenses/MIT).