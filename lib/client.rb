require 'player'

require 'client/socket'
require 'client/parser'
require 'client/mapper'

Thread.abort_on_exception = true

module Client
  extend self
  Server = ARGV.shift || '127.0.0.1' unless Client.const_defined? 'Server'
  
  def connect
    @thread = Thread.new do
      Client::Socket.open Server do |socket|
        loop do
          socket.puts Player.commands.shift unless Player.commands.empty?
          Player.data = Client::Mapper.new Client::Parser.run socket.gets
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