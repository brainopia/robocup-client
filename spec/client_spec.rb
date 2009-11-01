require 'spec/spec_helper'

describe Client do
  def reload_with_first_argv(value)
    ARGV[0] = value
    Client.send :remove_const, 'Server'
    load 'lib/client.rb'
  end

  it 'should define server constant' do
    Client.const_defined?('Server').should be_true
  end

  it 'should initialize server constant with 127.0.0.1 by default' do
    reload_with_first_argv nil
    Client::Server.should == '127.0.0.1'
  end

  it 'should set server constant according to console arguments' do
    reload_with_first_argv ip = '192.168.1.3'
    Client::Server.should == ip
  end

  it 'should communicate with server' do
    server = mock 'server'
    Client.should_receive(:interact_with).once.with(server).and_return { throw :interacted }
    lambda { Client.communicate_with server }.should throw_symbol(:interacted)
  end

  it 'should only listen to server during interaction if commands are empty' do
    Robot.commands.replace []
    Client.should_not_receive(:say_to)
    Client.should_receive(:listen_to).once
    Client.interact_with mock('server')
  end

  it 'should say and listen to server during interaction if commands are present' do
    Robot.commands.replace ['do something']
    Client.should_receive(:say_to).once.ordered
    Client.should_receive(:listen_to).once.ordered
    Client.interact_with mock('server')
  end

  it 'should say to server' do
    Robot.commands.replace ['(command 1)', '(command 2)', '(command 3)']
    server = mock 'server'
    server.should_receive(:puts).once.with '(command 1)(command 2)(command 3)'
    Client.say_to server
  end

  it 'should remove commands which were told server' do
    Robot.commands.replace ['(command 1)', '(command 2)', '(command 3)']
    Client.say_to mock('server', :null_object => true)
    Robot.commands.should == []
  end

  it 'should use slice! on commands so it do not loose new commands' do
    Robot.commands.replace ['(command 1)', '(command 2)', '(command 3)']
    Robot.commands.should_receive(:slice!).with(0, 3).and_return []
    Client.say_to mock('server', :null_object => true)
  end

  it 'should listen to server' do
    server = mock 'server'
    server.should_receive('gets').once.and_return 'message from server'
    Client::Parser.should_receive('run').once.with('message from server').and_return 'parsed message'
    Client::Mapper.should_receive('new').once.with('parsed message').and_return 'mapped message'
    Robot.should_receive('data=').once.with 'mapped message'
    Client.listen_to server
  end

  it 'should disconnect' do
    thread = mock 'thread'
    Client.instance_variable_set :@thread, thread
    thread.should_receive :exit
    Client.disconnect
  end

  it 'should reconnect' do
    Client.should_receive(:disconnect).once.ordered
    Client.should_receive(:connect).once.ordered
    Client.reconnect
  end
end