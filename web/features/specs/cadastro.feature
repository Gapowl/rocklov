#language: pt

Funcionalidade: Cadastro
    Sendo um músico que possui equipamentos musicais
    Quero fazer o meu cadastro no RockLov
    Para que eu possa disponibilizá-los para locação

    @cadastro
    Cenario: Fazer cadastro

        Dado que acesso a página de cadastro
        Quando submeto o seguinte formulario de cadastro:
            | nome            | email              | senha  |
            | Fernando Papito | fernando@gmail.com | 123456 |
        Então sou redirecionado para o Dashboard

    @tentativa_cadastro
    Esquema do Cenario: Tentativa de Cadastro

        Dado que acesso a página de cadastro
        Quando submeto o seguinte formulario de cadastro:
            | nome         | email         | senha         |
            | <nome_input> | <email_input> | <senha_input> |
        Então vejo a mensagem de alerta: "<mensagem>"

        Exemplos:
            | nome_input      | email_input        | senha_input | mensagem                         |
            |                 | fernando@gmail.com | 123456      | Oops. Informe seu nome completo! |
            | Fernando Papito |                    | 123456      | Oops. Informe um email válido!   |
            | Fernando Papito | fernando!gmail.com | 123456      | Oops. Informe um email válido!   |
            | Fernando Papito | fernando@gmail.com |             | Oops. Informe sua senha secreta! |