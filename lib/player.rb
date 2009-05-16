require 'extensions/kernel'

require 'player/observable'
require 'player/joint'
require 'player/pose'
require 'player/movement'

module Player
  extend self
  
  attr_reader :commands, :data
  @data     = {}  
  @commands = []
end