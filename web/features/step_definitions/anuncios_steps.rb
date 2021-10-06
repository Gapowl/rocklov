Dado("Login com {string} e {string}") do |email, senha|
  @email = email

  @login_page.open
  @login_page.with(email, senha)
  expect(@dashboard_page.on_dash?).to be true
end

Dado("que acesso o formulario de cadastro de anuncios") do
  @dashboard_page.goto_equipo_form
end

Dado("que eu tenho o seguinte equipamento:") do |table|
  @equipo = table.rows_hash

  MongoDB.new.remove_equip(@equipo[:nome], @email)

  # ^= é para quando começa com
  # *= é quando contem
  # $= é quando termina com
end

Quando("submeto o cadastro desse item") do
  @anuncio_page.create(@equipo)
end

Entao("devo ver esse item no meu Dashboard") do
  expect(@dashboard_page.equipo_list).to have_content @equipo[:nome]
  expect(@dashboard_page.equipo_list).to have_content "R$#{@equipo[:preco]}/dia"
end

Entao("deve conter a mensagem de alerta: {string}") do |expect_alert|
  # Contem = have_text
  expect(@alert.dark).to have_text expect_alert
end

# remover anuncios

Dado("que eu tenho um anuncio indesejado:") do |table|
  user_id = page.execute_script("return localStorage.getItem('user')")

  thumbnail=File.open(File.join(Dir.pwd + "/features/support/fixtures/images/", table.rows_hash[:thumb]), "rb")
  
  @equipo = {
    thumbnail: thumbnail,
    name: table.rows_hash[:nome],
    category: table.rows_hash[:categoria],
    price: table.rows_hash[:preco]
  }

  EquiposService.new.create(@equipo,user_id)

  visit current_path
end

Quando("eu solicito a exclusao desse item") do
  @dashboard_page.request_removal(@equipo[:name])

  expect(@dashboard_page.equipo_name.text).to eql @equipo[:name]
  expect(@dashboard_page.question_remove.text).to have_text "Deseja apagar esse anúncio?"
end

Quando("confirmo a exclusao") do
  @dashboard_page.confirm_remove
end

Quando("nao confirmo a exclusao") do
  @dashboard_page.decline_remove
end

Entao("o equipo permanece no Dashboard") do
  expect(@dashboard_page.has_no_equipo?(@equipo[:name])).to be false
end

Entao("nao devo ver esse item no meu Dashboard") do
  expect(@dashboard_page.has_no_equipo?(@equipo[:name])).to be true
end