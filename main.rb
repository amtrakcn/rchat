require 'socket'
require_relative 'server.rb'
require_relative 'room.rb'
require_relative 'user.rb'

server = TCPServer.new 2000
chat_service = Server.new
loop do
  cammand = ""
  Thread.start(server.accept) do |client|
    chat_service.current_connection = client
    client.puts "Hello !"
    client.puts "The time now is #{Time.now}"
    until cammand == "/quit"
      cammand = client.gets.chomp
      client.puts(cammand)
      client.puts(chat_service.excute(cammand))
    end

    client.puts("BYE!")
    client.close
  end
end