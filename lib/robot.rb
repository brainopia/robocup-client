require 'extensions/kernel'

require 'player/joint'
require 'player/pose'
require 'player/movement'

module Robot
  extend self
  
  attr_reader :commands, :data, :observers
  @data       = {}
  @commands   = []
  @observers  = {}

  def data=(new_data)
    @data.merge!(new_data)
    @observers.values.each {|it| it.call }
  end
end