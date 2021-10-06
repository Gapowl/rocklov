class DashboardPage
  include Capybara::DSL

  def goto_equipo_form
    click_button "Criar anúncio"
  end

  def equipo_list
    return find(".equipo-list")
  end

  def on_dash?
    return page.has_css?(".dashboard")
  end

  def request_removal(name)
    equipo = find(".equipo-list li", text: name)
    equipo.find(".delete-icon").click
  end

  def equipo_name
    return find(".react-confirm-alert-body h1")
  end

  def question_remove
    return find(".react-confirm-alert-body")
  end

  def confirm_remove
    click_on "Sim"
  end

  def decline_remove
    click_on "Não"
  end

  def has_no_equipo?(name)
    return page.has_no_css?(".equipo-list li", text: name)
  end

  def order
    find(".notifications p")
  end 

  def order_actions(name)
    return page.has_css?(".notifications button", text: name)
  end 

  def logout
  end
end
