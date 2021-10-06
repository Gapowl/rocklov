class LoginPage
  include Capybara::DSL

  def open
    visit "/"
  end

  def with(email, password)
    find("input[placeholder='Seu email']").set email
    find("input[placeholder='Sua senha secreta']").set password
    click_button "Entrar"
  end
end
