class User
  attr_accessor :name, :connection, :room_name

  def initialize(name, connection, room_name)
    @name = name
    @connection = connection
    @room_name = room_name
  end

end
