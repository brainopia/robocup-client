require 'player/joint'
require 'player/observable'

module Player
  extend self
  extend Observable
  
  attr_reader :commands, :data
  @commands = []
  @data = {}

  def data=(new_data)
    data.merge!(new_data) do |perceptor, old_value, new_value|
      notify_observers(perceptor, old_value, new_value) unless old_value == new_value
      new_value
    end
  end
  
  def joint
    Joint
  end  
end