describe "POST /equipos/{equipo_id}/bookings" do
  before(:all) do
    payload = { email: "eduardo@gmail.com.br", password: "123123" }
    result = Sessions.new.login(payload)
    @ed_id = result.parsed_response["_id"]
  end

  context "solicitar locacao" do
    before(:all) do

      result = Sessions.new.login({ email: "maria@gmail.com.br", password: "123123" })
      maria_id =  result.parsed_response["_id"]
      fender = {
        thumbnail: Helpers::get_thumb("fender-sb.jpg"),
        name: "Fender Strato",
        category: "Cordas",
        price: 299,
      }
      MongoDB.new.remove_equip(fender[:name], maria_id)

      result = Equipos.new.create(fender, maria_id)
      fender_id = result.parsed_response["_id"]

      @result = Equipos.new.booking(fender_id,@ed_id)

    end

    it "deve retornar 200" do
      expect(@result.code).to eql 200
    end

  end
end
