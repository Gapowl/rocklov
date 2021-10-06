describe "DELETE /equipos/{equipo_id}" do
  before(:all) do
    payload = { email: "kyan@ceia.com.br", password: "123123" }
    result = Sessions.new.login(payload)
    @user_id = result.parsed_response["_id"]
  end

  context "deletar unico equipo" do
    before(:all) do
      @payload = {
        thumbnail: Helpers::get_thumb("pedais.jpg"),
        name: "Pedais",
        category: "Áudio e Tecnologia".force_encoding("ASCII-8BIT"),
        price: 199,
      }
      
      MongoDB.new.remove_equip(@payload[:name],@user_id)

      equipo = Equipos.new.create(@payload, @user_id)
      @equipo_id = equipo.parsed_response["_id"]

      @result = Equipos.new.remove_by_id(@equipo_id, @user_id)
    end

    it "deve retornar 204" do
      expect(@result.code).to eql 204
    end

  end

  context "equipo nao existe" do
    before(:all) do
      @result = Equipos.new.remove_by_id(MongoDB.new.get_mongo_id, @user_id)
    end

    it "deve retornar 204" do
      expect(@result.code).to eql 204
    end
    
  end
end
