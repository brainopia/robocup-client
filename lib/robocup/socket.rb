require 'socket'

module Robocup
  class Socket < TCPSocket
    def pack_big_endian(number)
      [number].pack 'N'
    end
  
    def unpack_big_endian(string)
      string.unpack('N').first
    end
  
    def puts(message)
      message += "\n"      
      prefix = pack_big_endian message.size
      super prefix + message
    end
  
    def gets
      prefix = read 4
      read unpack_big_endian(prefix)
    end
    
    def self.open(server = '127.0.0.1', team = 'GoBrain', number = 0)
      super server, 3100 do |socket|
        ["(scene rsg/agent/nao/nao.rsg)", "(init (unum #{number})(teamname #{team}))"].each do |init_msg|
          socket.puts init_msg
          socket.gets
        end
      
        yield socket
      end
    end        
  end
end