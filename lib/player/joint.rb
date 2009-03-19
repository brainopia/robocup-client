require 'robocup/joints'

module Player
  module Joint
    extend self
    
    Robocup::Joints.effectors.each do |joint, effector|
      define_method joint do |speed|
        Player.commands.push "(#{effector} #{speed})"
      end
    end
    
  end
end
