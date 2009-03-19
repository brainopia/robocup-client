module Player
  module Joints
    
    @structure = { 
      :head       => [:h1, :h2],
      :left_arm   => [:la1, :la2, :la3, :la4],
      :right_arm  => [:ra1, :ra2, :ra3, :ra4],
      :left_leg   => [:ll1, :ll2, :ll3, :ll4, :ll5, :ll6],
      :right_leg  => [:rl1, :rl2, :rl3, :rl4, :rl5, :rl6]
    }
    
    @all = @structure.values.flatten

    @effectors = @all.inject({}) do |effectors, joint|
      # конвертируем название сочленения в название эффектора (к примеру, h1 к he1)
      effectors[joint] = joint.to_s.sub /(\D*)(\d)/, '\1e\2' 
      effectors
    end
    
    @effectors.each do |joint, effector|
      define_method "#{joint}=" do |angle|
        # TODO: 
        # 1) restrict max and min angle for each joint
        # 2) refactor this method
        # 3) add option to set custom speed and angle error
        # 4) add ability to choose between several presets varying by speed and angle error
        angle_error = 1
        destination_angle = (angle / angle_error).round
        
        current_angle = (data[joint] / angle_error).round
        
        if destination_angle != current_angle
          add_observer(joint) do |old_value, new_value|
            current_angle = (new_value / angle_error).round
            if current_angle == destination_angle            
              commands.push "(#{effector} 0)"
              throw :done 
            end
          end
          speed = 1
          speed *= (current_angle > destination_angle) ? -1 : 1
          commands.push "(#{effector} #{speed})"
        end
      end
      
      define_method joint do
        data[joint]
      end
    end
    
  end
end