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

# Если этот файл был запущен напрямую
if __FILE__ == $0
  # То запустить отдельный поток для общения с сервером
  Thread.new do
    Robocup::Socket.open '127.0.0.1', 3100 do |socket|
      Player.effector.init
    
      loop do
        socket.puts Player.effector.commands.shift unless Player.effector.commands.empty?
        Player.status = socket.gets
      end
    end
  end
end