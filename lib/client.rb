require 'lib/robot'

require 'lib/client/socket'
require 'lib/client/parser'
require 'lib/client/mapper'

Thread.abort_on_exception = true

module Client
  extend self
  Server = ARGV.first || '127.0.0.1' unless Client.const_defined? 'Server'

  def connect
    @thread = Thread.new { Socket.open(Server) {|it| communicate_with it }}
  end

  def disconnect
    @thread && @thread.exit
  end

  def reconnect
    disconnect
    connect
  end

  def communicate_with(socket)
    loop { iteraction commands }
  end
  
  def iteraction(commands)
    socket.puts commands.slice!(0, commands.size).join unless commands.empty?
    Robot.data = Mapper.new(Parser.run socket.gets)
  end
end