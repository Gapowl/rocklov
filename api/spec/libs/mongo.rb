require "mongo"

Mongo::Logger.logger = Logger.new("./logs/mongo.log")

class MongoDB
  attr_accessor :client, :users, :equipos

  def initialize
    @client = Mongo::Client.new("mongodb://rocklov-db:27017/rocklov")
    @users = client[:users]
    @equipos = client[:equipos]
  end

  def drop_danger
    client.database.drop
  end

  def insert_users(docs)
    @users.insert_many(docs)
  end

  def get_user(email)
    user = @users.find({ email: email }).first
    return user[:_id]
  end

  def remove_user(email)
    @users.delete_many({ email: email })
  end

  def remove_equip(nome, user_id)
    obj_id = BSON::ObjectId.from_string(user_id)
    @equipos.delete_many({ name: nome, user: obj_id })
  end

  def get_mongo_id
    return BSON::ObjectId.new
  end
end
