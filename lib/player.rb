require 'robocup/socket'
require 'player/status'
require 'player/effector'

module Player
  extend self
  attr_reader :status
  
  def status=(sexp)
    @status = Status.new sexp
  end
  
  def effector
    Player::Effector
  end  
end

# В данном потоке будет происходить общение с сервером
Thread.new do
  Robocup::Socket.open '127.0.0.1', 3100 do |socket|
    Player.effector.init
    
    loop do
      socket.puts Player.effector.commands.shift unless Player.effector.commands.empty?
      Player.status = socket.gets
    end
  end
end