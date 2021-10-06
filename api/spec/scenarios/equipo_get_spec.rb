describe "GET /equipos/{equipos_id}" do
  before(:all) do
    payload = { email: "jojo@canal.com.br", password: "123123" }
    result = Sessions.new.login(payload)
    @user_id = result.parsed_response["_id"]
  end

  context "obter unico equipo" do
    before(:all) do
      @payload = {
        thumbnail: Helpers::get_thumb("sanfona.jpg"),
        name: "Sanfona",
        category: "Outros",
        price: 669,
      }
      MongoDB.new.remove_equip(@payload[:name],@user_id)

      equipo = Equipos.new.create(@payload, @user_id)
      @equipo_id = equipo.parsed_response["_id"]

      @result = Equipos.new.find_by_id(@equipo_id, @user_id)
    end

    it "deve retornar 200" do
      expect(@result.code).to eql 200
    end

    it "deve ter o nome " do
      expect(@result.parsed_response).to include("name" => @payload[:name])
    end
  end

  context "equipo nao existe" do
    before(:all) do
      @result = Equipos.new.find_by_id(MongoDB.new.get_mongo_id, @user_id)
    end

    it "deve retornar 404" do
      expect(@result.code).to eql 404
    end
    
  end

end

describe "GET /equipos" do
  before(:all) do
    payload = { email: "fire@base.com.br", password: "123123" }
    result = Sessions.new.login(payload)
    @user_id = result.parsed_response["_id"]
  end

  context "obter uma lista" do
    before(:all) do
      payloads = [{
        thumbnail: Helpers::get_thumb("sanfona.jpg"),
        name: "Sanfona",
        category: "Outros",
        price: 700,
      },{
        thumbnail: Helpers::get_thumb("trompete.jpg"),
        name: "Trompete",
        category: "Outros",
        price: 350,
      },{
        thumbnail: Helpers::get_thumb("slash.jpg"),
        name: "Les Paul",
        category: "Corda",
        price: 525,
      },]

      payloads.each do |payload|
        MongoDB.new.remove_equip(payload[:name],@user_id)
        Equipos.new.create(payload,@user_id)
      end

      @result = Equipos.new.list(@user_id)
    end

    it "deve retornar 200" do
      expect(@result.code).to eql 200
    end

    it "deve retornar uma lista de equipos" do
      expect(@result.parsed_response).not_to be_empty
      expect(@result.parsed_response.class).to eql Array
    end

  end
end
