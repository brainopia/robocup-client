require 'extensions/kernel'

require 'player/observable'
require 'player/joint'
require 'player/pose'
require 'player/movement'

module Robot
  extend self
  
  attr_reader :commands, :data
  @data     = {}  
  @commands = []
end