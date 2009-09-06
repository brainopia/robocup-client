require 'lib/client/socket'

Thread.abort_on_exception = true

describe Client::Socket do
  def disable_socket_method(name)
    Client::Socket.module_eval do
      alias_method :"original_#{name}", name
      define_method(name) {|*args|}
    end
  end

  def enable_socket_method(name)
    Client::Socket.module_eval do
      alias_method name, :"original_#{name}"
    end
  end

  def open_socket(server = '127.0.0.1', *args)
    Client::Socket.open server, *args do |socket|
      yield socket if block_given?
    end
  end

  before(:all) do
    @server = TCPServer.open '3100'
    
    @message = 'test'
    @big_endian_size = Client::Prefix.pack @message.size    
    
    @message_with_newline = @message + "\n"    
    @big_endian_size_with_newline = Client::Prefix.pack @message_with_newline.size
  end

  after(:all) do
    @server.close
  end

  describe 'communication' do
    before(:all) do
      disable_socket_method :initialize_client
    end
  
    after(:all) do
      enable_socket_method :initialize_client
    end
  
    it 'should put robocup messages' do
      open_socket {|it| it.puts @message }
      @server.accept.gets.should == @big_endian_size_with_newline + @message_with_newline
    end
  
    it 'should get robocup messages' do
      Thread.new { @server.accept.write @big_endian_size + @message }
      open_socket {|it| it.gets.should == @message }
    end
  end

  describe 'initialize client' do
    before(:all) do
      disable_socket_method :gets
    end

    after(:all) do
      enable_socket_method :gets
    end

    it 'should put initialization messages' do      
      open_socket
      server = @server.accept
      ["(scene rsg/agent/nao/nao.rsg)", "(init (unum 0)(teamname GoBrain))"].each do |expected|
        init_message = Client::Prefix.pack(expected.size + 1) + expected + "\n"
        server.gets.should == init_message
      end
    end
    
    it 'should set server value' do
      Thread.new { @server.accept }
      open_socket('localhost') {|it| it.peeraddr[3] == 'localhost' }
    end

    it 'should set team value' do
      open_socket '127.0.0.1', 'FooBarTeam'
      server = @server.accept
      ["(scene rsg/agent/nao/nao.rsg)", "(init (unum 0)(teamname FooBarTeam))"].each do |expected|
        init_message = Client::Prefix.pack(expected.size + 1) + expected + "\n"
        server.gets.should == init_message
      end
    end

    it 'should set number value' do
      open_socket '127.0.0.1', 'FooBarTeam', 3
      server = @server.accept
      ["(scene rsg/agent/nao/nao.rsg)", "(init (unum 3)(teamname FooBarTeam))"].each do |expected|
        init_message = Client::Prefix.pack(expected.size + 1) + expected + "\n"
        server.gets.should == init_message
      end
    end
  end
end