require 'robocup/socket'

module Player
  extend self
  attr_reader :status
  
  def status=(sexp)
    @status = Status.new sexp
  end
end

# В данном потоке будет происходить общение с сервером
Thread.new do
  Robocup::Socket.open '127.0.0.1', 3100 do |socket|
    ["(scene rsg/agent/nao/nao.rsg)", "(init (unum 0)(teamname NaoRobot))"].each do |init_msg|
      socket.puts init_msg
      socket.gets
    end
    
    loop { Player.status = socket.gets }
  end
end