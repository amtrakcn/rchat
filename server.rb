require 'set'

class Server
  attr_accessor :current_connection

  def initialize
    @rooms = Hash.new()
    @users = Hash.new()
    create_room("lobby")
    @current_connection = nil
    @current_user = nil
  end

  def excute(cammand)
    operation, value = cammand.split(" ", 2)
    operation = operation[1..-1].downcase.to_sym

    begin
      puts "try"
      if value
        puts value
         self.send(operation, value)
      else
         self.send(operation)
      end
    rescue
      "invalid cammand"
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

    @users.each do |user|
        return user.room_name if user.name == name
    end
    "Sorry, user #{name} is not online now"
  end

  def login(name)
    if @users.has_key?(name)
      return "Naming confclit"
    else
      @rooms["lobby"].members << User.new(name, @current_connection, "looby")
      @users[name] = user
    end
    "User #{name} created"
  end

  def logoff(user)
    @rooms[user.room_name].delete(user)
    @users.delete(user.name)
    "User #{user.name} logged off"
  end
  
  def list_user
    @rooms[@current_user.room_name].members.each do |single_user|
      @current_user.puts("*#{single_user.name}")
    end
  end
  
  def room(message)
    @rooms[@current_user.room_name].members.each do |single_user|
      single_user.connection.puts(message)
    end
  end
  
  def private_message(name, message)
    @users[name].connection.puts(message)
  def 

end
