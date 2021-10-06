require_relative "routes/signup"
require_relative "routes/sessions"
require_relative "routes/equipos"

require_relative "libs/mongo"
require_relative "helpers"

require "digest/md5"

def to_md5(pass)
  return Digest::MD5.hexdigest(pass)
end

RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end
  config.shared_context_metadata_behavior = :apply_to_host_groups

  config.before(:suite) do
    users = [
      {name: "Alan Silva", email:"alan@gmail.com.br", password: to_md5("123123")},
      {name: "Karlos Kazimuro", email:"kaka@ig.com", password: to_md5("123123")},
      {name: "Joao Vitor", email:"joao@yahoo.com", password: to_md5("joaozinho333")},
      {name: "Maria Silva", email:"ma@rilao.com.br", password: to_md5("123123")},
      {name: "Leao Santos Silva", email:"fire@base.com.br", password: to_md5("123123")},
      {name: "Jonatas Mano Jhow", email:"jojo@canal.com.br", password: to_md5("123123")},
      {name: "Kyan Peira", email:"kyan@ceia.com.br", password: to_md5("123123")},
      {name: "Eduardo Vilas Ruins", email:"eduardo@gmail.com.br", password: to_md5("123123")},
      {name: "Maria Peira", email:"maria@gmail.com.br", password: to_md5("123123")}
    ]

    MongoDB.new.drop_danger
    MongoDB.new.insert_users(users)
  end
end
