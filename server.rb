require 'set'
require 'singleton'

class Server
  def initialize
    @rooms = Hash.new(Room.new())
    create_room("lobby")
    @user_names = Set.new
  end

  def excute(cammand)
    operation, value = cammand.split(" ")
    operation = operation[1..-1].downcase.to_sym
    
    if value
       self.send(operation, value)
    else
       self.send(operation)
    end
  end

  def create_room(name)
    if @rooms[name].nil?
      @rooms[name] = Room.new(name)
    else
      return "Room already exists"
    end
    "Room #{name} created"
  end

  def join(room_name, user)
    if @rooms[room_name].nil?
      return "Room #{room_name} does not exist!"
    else
      @rooms[room_name].members.add（user）
      @rooms[user.room_name].members.delete(user)
      user.room_name = room_name
    end
    "Entered room #{room_name}"
  end

  def find(name)
    return "Please specify name of the user you are looking for !" if name.nil?

    @rooms.each do |room|
      room.members.each do |user|
        return user.room_name if user.name == name
      end
    end
    "Sorry, user #{name} is not online now"
  end

  def login(name)
    if @user_names.include?(name)
      return "Naming confclit"
    else
      @rooms["lobby"].members << User.new(name)
      @user_name.add(name)
    end
    "User #{name} created"
  end

  def logoff(user)
    @rooms[user.room_name].delete(user)
    @user_names.delete(user.name)
    "User #{user.name} logged off"
  end

end
