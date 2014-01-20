require 'socket'

chat_server = TCPServer.new 2000
loop do
  #connect puts (chat_server.excute(connection.gets))

  Thread.start(server.accept) do |client|
  end
end