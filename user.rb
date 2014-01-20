class User
  attr_accessor :user, :connection

  def initialize(name, connection, room_name)
    @name = name
    @connection = connection
    @room_name = room_name
  end

end