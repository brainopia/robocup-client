require 'socket'
require 'lib/client/prefix'

module Client
  class Socket < TCPSocket
    
    def self.open(server = '127.0.0.1', team = 'GoBrain', number = 0)
      begin
        super server, 3100 do |socket|
          socket.initialize_client team, number
          yield socket
        end
      rescue Errno::ECONNREFUSED
        puts "Simspark isn't running on #{server}"
        exit
      end
    end

    def initialize_client(team, number)
      ["(scene rsg/agent/nao/nao.rsg)", "(init (unum #{number})(teamname #{team}))"].each do |message|
        puts message
        gets
      end
    end

    def puts(message)
      message += "\n"
      prefix = Prefix.pack message.size
      super prefix + message
    end

    def gets
      prefix = read 4
      unless prefix
        Kernel.puts 'Connection to simspark is lost'
        exit
      end
      read Prefix.unpack(prefix)
    end
  end
end