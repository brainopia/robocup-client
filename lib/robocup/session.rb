require 'player'

require 'robocup/socket'
require 'robocup/parser'
require 'robocup/mapper'

SERVER = ARGV.shift || '127.0.0.1'
Thread.abort_on_exception = true

Thread.new do
  Robocup::Socket.open SERVER do |socket|
    loop do
      socket.puts Player.commands.shift unless Player.commands.empty?
      Player.data = Robocup::Mapper.new Robocup::Parser.run socket.gets
    end
  end  
end

