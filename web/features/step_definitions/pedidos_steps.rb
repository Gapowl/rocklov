Dado('que meu perfil de anunciante é {string} e {string}:') do |email, password|
    @email_anunciante=email
    @pass_anunciante=password
end

Dado('que eu tenho o seguinte equipamento cadastrddo:') do |table|
    user_id = SessionsService.new.get_user_id(@email_anunciante,@pass_anunciante)

    thumbnail=File.open(File.join(Dir.pwd + "/features/support/fixtures/images/", table.rows_hash[:thumb]), "rb")
    
    @equipo = {
      thumbnail: thumbnail,
      name: table.rows_hash[:nome],
      category: table.rows_hash[:categoria],
      price: table.rows_hash[:preco]
    }
    MongoDB.new.remove_equip(@equipo[:name],@email_anunciante)
  
    result = EquiposService.new.create(@equipo,user_id)
    @equipo_id = result.parsed_response["_id"]
end

Dado('acesso o meu dashboard') do
    @login_page.open
    @login_page.with(@email_anunciante,@pass_anunciante)

    expect(@dashboard_page.on_dash?).to be true
end

Quando('{string} e {string} solicita locao desse equipo') do |email, password|
    @email_locatario=email
    @pass_locatario=password

    locatario_id = SessionsService.new.get_user_id(@email_locatario,@pass_locatario)

    EquiposService.new.booking(@equipo_id,locatario_id)
end

Entao('devo ver a seguinte mensagem:') do |doc_string|
  expect_messege = doc_string.gsub("DATA_ATUAL",Time.now.strftime("%d/%m/%Y"))

  expect(@dashboard_page.order).to have_text expect_messege
end

Entao('devo ver os links: {string} e {string} no pedido') do |button_acceot, button_decline|
    expect(@dashboard_page.order_actions(button_acceot)).to be true
    expect(@dashboard_page.order_actions(button_decline)).to be true
end