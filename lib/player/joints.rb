module Player
  attr_reader :structure, :all, :effectors
  
  @structure = { 
    :head       => [:h1, :h2],
    :left_arm   => [:la1, :la2, :la3, :la4],
    :right_arm  => [:ra1, :ra2, :ra3, :ra4],
    :left_leg   => [:ll1, :ll2, :ll3, :ll4, :ll5, :ll6],
    :right_leg  => [:rl1, :rl2, :rl3, :rl4, :rl5, :rl6]
  }
  
  @all = @structure.values.flatten

  @effectors = @all.inject({}) do |effectors, joint|
    # конвертируем название cустава в название эффектора (к примеру, h1 к he1)
    effectors[joint] = joint.to_s.sub /(\D*)(\d)/, '\1e\2' 
    effectors
  end
  
  @effectors.each do |joint, effector|
    define_method "#{joint}=" do |angle|
      send joint, :angle => angle
    end
        
    eval <<CODE
      # TODO: restrict max and min angle for each joint
      # TODO: remove observer if joint is stuck
      # TODO: refactor this method
      # TODO: add option to set custom speed and angle error
      # TODO: add ability to choose between several presets varying by speed and angle error          
    
      def #{joint}(options=nil)
        joint = "#{joint}".to_sym
        effector = "#{effector}"
        
        return data[joint] unless options
        
        speed       = options[:speed]       || 10
        angle_error = options[:angle_error] || 5
        angle       = options[:angle]       || 0
        
        destination_angle_with_error = (angle / angle_error).round      
        current_angle_with_error = (data[joint] / angle_error).round

        if destination_angle_with_error != current_angle_with_error
          
          add_observer(joint, :manipulator) do |old_value, new_value|
            current_angle_with_error = (new_value / angle_error).round
            
            if current_angle_with_error == destination_angle_with_error
              move effector, 0
              @observers[joint][:manipulator] = nil
              yield if block_given?              
            end
          end
          
          speed *= (current_angle_with_error > destination_angle_with_error) ? -1 : 1 # направление движения
          move effector, speed
        else          
          remove_observer joint, :manipulator
          move effector, 0
          yield if block_given?
        end              
      end      
CODE

  end
  
  private 
  
  def move(effector, speed)
    commands.push "(#{effector} #{speed})"
  end
end