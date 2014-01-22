class Server
  attr_accessor :current_connection, :current_user

  def initialize
    @rooms = Hash.new()
    @users = Hash.new()
    create_room("lobby")
    @current_connection = nil
    @current_user = nil
  end

  def find_user_by_connection(connection)
    @users.each_value do |user|
      return user if user.connection == connection
    end
    nil
  end

  def excute(cammand)
    operation, value = cammand.split(" ", 2)
    operation = operation[1..-1].downcase.to_sym

    begin
      puts "try"
      if value
        self.send(operation, value)
      else
        self.send(operation)
      end
    #rescue
    #  "invalid cammand"
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
      user = User.new(name, @current_connection, "lobby")
      @rooms["lobby"].members << user
      @users[name] = user
      @current_user = user
    end
    "User #{name} created"
  end

  def logoff(user)
    @rooms[user.room_name].delete(user)
    @users.delete(user.name)
    @current_user = nil
    "User #{user.name} logged off"
  end
  
  def list_user
    puts("rooms are #{@rooms}")
    puts("#{@current_user.room_name}")
    puts("members are #{@rooms[@current_user.room_name].members}")
    @rooms[@current_user.room_name].members.each do |single_user|
      puts("* #{single_user.name}")
      @current_user.connection.puts("* #{single_user.name}")
    end
    ""
  end
  
  def room(message)
    @rooms[@current_user.room_name].members.each do |single_user|
      single_user.connection.puts(message)
    end
    ""
  end
  
  def private_message(cammand)
    name, message = cammand.split(" ", 2)
    @users[name].connection.puts(message)
    ""
  end

end
