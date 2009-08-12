require 'yaml'

module Robot
  
  def do
    Movement
  end
  
  module Movement
    extend self
    
    Dir.glob('lib/player/movement/*.yml').each do |movement_file|
      movements = YAML.load_file movement_file
      movement_name = File.basename movement_file, '.yml'
      
      define_method(movement_name) { make movements }      
    end
    
    def make(movements)
      if movements.is_a? Array
        movements.each {|movement| make movement }
      elsif movements.is_a? Hash
        movements.each do |first_movement, next_movements|
          Robot.pose.send(first_movement) { make next_movements }
        end
      else
        Robot.pose.send movements
      end
    end    
    
  end  
end