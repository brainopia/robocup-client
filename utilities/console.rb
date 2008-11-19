require 'socket'
require 'io/wait'

class RobocupSocket < TCPSocket
  def pack_big_endian(number)
    [number].pack 'N'
  end
  
  def unpack_big_endian(string)
    string.unpack('N').first
  end
  
  def puts(message)
    prefix = pack_big_endian message.size
    super prefix + message
  end
  
  def gets
    prefix = read 4
    read unpack_big_endian(prefix)
  end    
end

# Gracefully kill a client by ctrl-c
trap('INT') { exit }

RobocupSocket.open '127.0.0.1', 3100 do |socket|
  ["(scene rsg/agent/nao/nao.rsg)", "(init (unum 0)(teamname NaoRobot))"].each do |init_msg|
    socket.puts init_msg
    socket.gets
  end

  loop do
    if STDIN.ready?
      socket.puts gets
      puts socket.gets
      started = true
    elsif started
      socket.gets
    end
  end  
end