#language: pt

Funcionalidade: Login
    Sendo um usuário cadastrado
    Quero acessar o sistema da Rocklov
    Para que eu possa anunciar meus equipamentos musicais

    @login
    Cenario: Login do usuário

        Dado que acesso a página principal
        Quando submeto minhas credenciais "gabriel@gmail.com" e "678901"
        Então sou redirecionado para o Dashboard

    @tentativa_login
    Esquema do Cenario: Tentativa de Login

        Dado que acesso a página principal
        Quando submeto minhas credenciais "<email_input>" e "<senha_input>"
        Então vejo a mensagem de alerta: "<mensagem>"

        Exemplos:
            | email_input          | senha_input | mensagem                         |
            | gabriel@gmail.com    | 191919      | Usuário e/ou senha inválidos.    |
            | gabriel@gmail.com.br | 678901      | Usuário e/ou senha inválidos.    |
            | gabriel1gmail.com    | 678901      | Oops. Informe um email válido!   |
            |                      | 678901      | Oops. Informe um email válido!   |
            | gabriel@gmail.com    |             | Oops. Informe sua senha secreta! |