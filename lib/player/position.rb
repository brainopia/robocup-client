require 'yaml'

module Player
  
  def position
    Position
  end
  
  module Position
    extend self
    
    Dir.glob('lib/player/position/*.yml').each do |position_file|
      position = YAML.load_file position_file
      position_name = File.basename position_file, '.yml'
      
      define_method position_name do
        position.each do |joint, angle|
          Player.send "#{joint}=", angle
        end
      end
    end
  end
    
end