class Server
  def initialize
    @rooms = []
    create_room("lobby")
  end

  def parse(cammand)
    operation, value = cammand.split(" ")
    operation = operation[1..-1].downcase.to_sym
    
    if value
       self.send(operation, key)
    else
       self.send(operation)
    end
  end

  def create_room(name)
    @rooms << Room.new(name)
  end
end
