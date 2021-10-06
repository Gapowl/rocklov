#language: pt

Funcionalidade: Receber pedido de locao
    Sendo um anúnciante que possui um equipamento a ser luado
    Quero receber pedidos de locao
    Para que eu possa decidir se quero aprova-los ou rejeitalos

    @temp
    Cenario: Receber pedido
        Dado que meu perfil de anunciante é "marcio@anunciante.com" e "123123":
            E que eu tenho o seguinte equipamento cadastrddo:
            | nome      | Pedal      |
            | categoria | Outros     |
            | preco     | 70         |
            | thumb     | pedais.jpg |
            E acesso o meu dashboard
        Quando "klerico@locatario.com" e "123123" solicita locao desse equipo
        Entao devo ver a seguinte mensagem:
            """
            klerico@locatario.com deseja alugar o equipamento: Pedal em: DATA_ATUAL
            """
            E devo ver os links: "ACEITAR" e "REJEITAR" no pedido