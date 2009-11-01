module Client
  extend self
  Server = ARGV.first || '127.0.0.1' unless Client.const_defined? 'Server'

  def connect
    @thread = Thread.new { Socket.open(Server) {|it| communicate_with it }}
  end

  def disconnect
    @thread && @thread.exit
  end

  def reconnect
    disconnect
    connect
  end

  def communicate_with(server)
    loop { interact_with server }
  end

  def interact_with(server)
    say_to server unless Robot.commands.empty?
    listen_to server
  end

  def say_to(server)
    server.puts Robot.commands.slice!(0, Robot.commands.size).join
  end

  def listen_to(server)
    Robot.data = Mapper.new(Parser.run server.gets)
  end
end