require 'yaml'

module Player
  
  def pose
    Pose
  end
  
  module Pose
    extend self
    
    Dir.glob('lib/player/pose/*.yml').each do |pose_file|
      pose = YAML.load_file pose_file
      pose_name = File.basename pose_file, '.yml'
      
      define_method pose_name do
        pose.each do |joint, angle|
          Player.send "#{joint}=", angle
        end
      end
    end
  end
    
end