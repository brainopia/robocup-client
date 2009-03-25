require 'player/observable'
require 'player/joints'
require 'player/pose'
require 'player/movement'

module Player
  extend self
  
  attr_reader :commands, :data
  @commands = []
  @data = {}  
end