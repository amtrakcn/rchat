class Server
  def initialize
    @rooms = Array.new(){Array.new()}
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
end
