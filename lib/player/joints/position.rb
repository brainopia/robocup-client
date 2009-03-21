require 'yaml'

module Player
  module Joints    
    module Position
      Dir.glob('lib/player/joints/positions/*.yml').each do |position_file|
        position = YAML.load_file position_file
        position_name = File.basename position_file, '.yml'
        
        define_method position_name do
          position.each do |joint, angle|
            send "#{joint}=", angle
          end
        end
      end
    end
    
    include Position
  end
end