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
      prefix = pack_big_endian message.size
      super prefix + message
    end
  
    def gets
      prefix = read 4
      read unpack_big_endian(prefix)
    end    
  end
end