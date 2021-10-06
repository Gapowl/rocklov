#language: pt

Funcionalidade: Cadastro de Anúncios
    Sendo usuario cadastro no RockLov que possui equipamentos musicais
    Quero cadastrar meus equipamentos
    Para que eu posso disponibilizalos para locação


    Contexto:
        * Login com "augusto@ig.com" e "123123"

    Cenario: Novo equipamento

        Dado que acesso o formulario de cadastro de anuncios
            E que eu tenho o seguinte equipamento:
            | nome      | Fender Strato |
            | categoria | Cordas        |
            | preco     | 200           |
            | thumb     | fender-sb.jpg |
        Quando submeto o cadastro desse item
        Entao devo ver esse item no meu Dashboard

    Esquema do Cenario: Tentativa de cadastro de anúncions

        Dado que acesso o formulario de cadastro de anuncios
            E que eu tenho o seguinte equipamento:
            | nome      | <name_input>     |
            | categoria | <category_input> |
            | preco     | <price_input>    |
            | thumb     | <thumb_input>    |
        Quando submeto o cadastro desse item
        Entao deve conter a mensagem de alerta: "<mensagem_input>"

        Exemplos:
            | name_input        | category_input | price_input | thumb_input   | mensagem_input                       |
            | Violao de nylon   | Cordas         | 150         |               | Adicione uma foto no seu anúncio!    |
            |                   | Outros         | 250         | clarinete.jpg | Informe a descrição do anúncio       |
            | Microfone Shure   |                | 100         | mic.jpg       | Informe a categoria                  |
            | Trompete Clássico | Cordas         |             | trompete.jpg  | Informe o valor da diária            |
            | Conga             | Outros         | aaaaa       | conga.jpg     | O valor da diária deve ser numérico! |
            | Conga             | Outros         | 100aaaaa    | conga.jpg     | O valor da diária deve ser numérico! |