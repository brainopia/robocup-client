require 'lib/extensions/kernel'

require 'lib/robot/joint'
require 'lib/robot/pose'
require 'lib/robot/movement'

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