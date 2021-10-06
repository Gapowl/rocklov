#language: pt

Funcionalidade: Remover Anúncios
    Sendo um anúnciante que possui um equipamento indesejado
    Quero poder remover esse Anúncios
    Para que eu possa manter o meu Dashboard atualizado

    Contexto:
        * Login com "gabiru@ig.com" e "123123"

    Cenario: Remover um anuncio
        Dado que eu tenho um anuncio indesejado:
            | nome      | Fender Strato |
            | categoria | Cordas        |
            | preco     | 200           |
            | thumb     | fender-sb.jpg |
        Quando eu solicito a exclusao desse item
            E confirmo a exclusao
        Entao nao devo ver esse item no meu Dashboard

    Cenario: Desistir da exclusao
        Dado que eu tenho um anuncio indesejado:
            | nome      | Fender Strato |
            | categoria | Cordas        |
            | preco     | 200           |
            | thumb     | fender-sb.jpg |
        Quando eu solicito a exclusao desse item
            E nao confirmo a exclusao
        Entao o equipo permanece no Dashboard