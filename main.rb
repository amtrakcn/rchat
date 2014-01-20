require 'socket'

server = TCPServer.new 2000
loop do
  chat_service = Server.new
  cammand = ""
  Thread.start(server.accept) do |client|
    client.puts "Hello !"
    client.puts "The time now is #{Time.now}"
    while (cammand = client.gets) != "/quit"
      client.puts(chat_service.excute(cammand))
    end

    client.puts("BYE!")
  end
end