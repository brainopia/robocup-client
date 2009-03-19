require 'player'

require 'robocup/socket'
require 'robocup/parser'
require 'robocup/mapper'

Thread.abort_on_exception = true

module Robocup
  extend self
  Server = ARGV.shift || '127.0.0.1' unless Robocup.const_defined? 'Server'
  
  def start    
    @thread = Thread.new do
      Robocup::Socket.open Server do |socket|
        loop do
          socket.puts Player.commands.shift unless Player.commands.empty?
          Player.data = Robocup::Mapper.new Robocup::Parser.run socket.gets
        end
      end
    end
  end
  
  def stop
    @thread && @thread.exit
  end
  
  def restart
    stop
    start
  end
end