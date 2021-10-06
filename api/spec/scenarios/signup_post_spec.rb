describe "POST /signup" do
  context "novo usuario" do
    before(:all) do
      payload = { name: "Karlos Kazimuro", email: "kaka@ig.com", password: "123123" }
      MongoDB.new.remove_user(payload[:email])

      @result = Signup.new.create(payload)
    end

    it "valida status code" do
      expect(@result.code).to eql 200
    end

    it "valida id do usuario" do
      expect(@result.parsed_response["_id"].length).to eql 24
    end
  end

  context "usuario ja existe" do
    before(:all) do
      payload = { name: "Joao Vitor", email: "joao@yahoo.com", password: "joaozinho333" }
      MongoDB.new.remove_user(payload[:email])

      Signup.new.create(payload)
      @result = Signup.new.create(payload)
    end

    it "valida status code" do
      expect(@result.code).to eql 409
    end

    it "valida codigo de erro de negocio" do
      expect(@result.parsed_response["code"]).to eql 1001
    end

    it "valida mensagem de erro" do
      expect(@result.parsed_response["error"]).to eql "Email already exists :("
    end
  end

  exemples = [
    {
      title: "Nome em branco",
      payload: { name: "", email: "maria@ibm.com", password: "mari321" },
      code: 412,
      error: "required name",
    },
    {
      title: "Sem o campo name",
      payload: { email: "maria@ibm.com", password: "mari321" },
      code: 412,
      error: "required name",
    },
    {
      title: "Email em branco",
      payload: { name: "Maria Cristina", email: "", password: "mari321" },
      code: 412,
      error: "required email",
    },
    {
      title: "Sem o campo email",
      payload: { name: "Maria Cristina", password: "mari321" },
      code: 412,
      error: "required email",
    },
    {
      title: "Senha em branco",
      payload: { name: "Maria Cristina", email: "maria@ibm.com", password: "" },
      code: 412,
      error: "required password",
    },
    {
      title: "Senha em branco",
      payload: { name: "Maria Cristina", email: "maria@ibm.com" },
      code: 412,
      error: "required password",
    },
  ]

  exemples.each do |e|
    context e[:title] do
      before(:all) do
        payload = e[:payload]
        MongoDB.new.remove_user(payload[:email])

        @result = Signup.new.create(payload)
      end

      it "valida status code" do
        expect(@result.code).to eql e[:code]
      end

      it "valida mensagem de erro" do
        expect(@result.parsed_response["error"]).to eql e[:error]
      end
    end
  end
end
