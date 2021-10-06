
describe "POST /sessions" do
  context "login com sucesso" do
    #before(:all) do -> roda uma vez para TODOS os it`s
    #before do -> roda uma vez para CADA it
    before(:all) do
      payload = { email: "alan@gmail.com.br", password: "123123" }
      @result = Sessions.new.login(payload)
      #puts result.class
      #puts result.parsed_response
      #puts result.parsed_response.class
    end

    it "valida status code" do
      expect(@result.code).to eql 200
    end

    it "valida id do usuario" do
      expect(@result.parsed_response["_id"].length).to eql 24
    end
  end

#   exemples = [
#     {
#       title: "Senha incorreta",
#       payload: { email: "alan@gmail.com.br", password: "alan125" },
#       code: 401,
#       error: "Unauthorized",
#     },
#     {
#       title: "Email nao cadastrado",
#       payload: { email: "alan@gmail.com", password: "alan123" },
#       code: 401,
#       error: "Unauthorized",
#     },
#     {
#       title: "Email em branco",
#       payload: { email: "", password: "alan123" },
#       code: 412,
#       error: "required email",
#     },
#     {
#       title: "Sem o campo Email",
#       payload: { password: "alan123" },
#       code: 412,
#       error: "required email",
#     },
#     {
#       title: "Senha em branco",
#       payload: { email: "alan@gmail.com.br", password: "" },
#       code: 412,
#       error: "required password",
#     },
#     {
#       title: "Sem o campo senha",
#       payload: { email: "alan@gmail.com.br" },
#       code: 412,
#       error: "required password",
#     },
#   ]
exemples = Helpers::get_fixture("login")

exemples.each do |e|
    context e[:title] do
      before(:all) do
        @result = Sessions.new.login(e[:payload])
      end

      it "valida status code #{e[:code]}" do
        expect(@result.code).to eql e[:code]
      end

      it "valida id do usuario" do
        expect(@result.parsed_response["error"]).to eql e[:error]
      end
    end
  end
end
