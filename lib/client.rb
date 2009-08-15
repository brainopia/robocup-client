require 'lib/robot'

require 'lib/client/socket'
require 'lib/client/parser'
require 'lib/client/mapper'

Thread.abort_on_exception = true

module Client
  extend self
  Server = ARGV.first || '127.0.0.1' unless Client.const_defined? 'Server'

  def connect
    @thread = Thread.new do
      Socket.open Server do |socket|
        commands = Robot.commands
        loop do
          unless commands.empty?
            socket.puts commands.slice!(0, commands.size).join
          end
          Robot.data = Mapper.new(Parser.run socket.gets)
        end
      end
    end
    sleep 0.1 # give time for a socket to be properly initialized in the second thread
  end
  
  def disconnect
    @thread && @thread.exit
  end
  
  def reconnect
    disconnect
    connect
  end
end