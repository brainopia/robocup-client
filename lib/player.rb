require 'robocup/socket'
require 'player/status'
require 'player/status/vision'
require 'player/status/joints'
require 'player/status/force'
require 'player/effector'

module Player
  extend self
  attr_reader :commands
  @commands = []

  def status
    Status
  end
  
  def status=(sexp)
    Status.data = sexp
  end
  
  def joint
    Joint
  end  
end

# Если этот файл был запущен напрямую
if __FILE__ == $0
  # То запустить отдельный поток для общения с сервером
  SERVER = ARGV.first || '127.0.0.1'

  Thread.new do
    Robocup::Socket.open SERVER do |socket|

      loop do
        socket.puts Player.commands.shift unless Player.commands.empty?
        Player.status = socket.gets
      end
    end
  end
end