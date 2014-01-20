class Room
  attr_accessor :members, :name

  def initialize(name)
    @name = name
    @members = []
  end
end