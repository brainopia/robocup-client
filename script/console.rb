#!/usr/bin/env ruby

require 'socket'
require 'io/wait'

$:.unshift File.join(File.dirname(__FILE__), '..', 'lib')
require 'robocup/socket'

# Gracefully kill a client by ctrl-c
trap('INT') { exit }

Robocup::Socket.open '127.0.0.1', 3100 do |socket|
  ["(scene rsg/agent/nao/nao.rsg)", "(init (unum 0)(teamname NaoRobot))"].each do |init_msg|
    socket.puts init_msg
    socket.gets
  end

  loop do
    if STDIN.ready?
      socket.puts gets
      puts socket.gets
    else
      socket.gets
    end
  end  
end