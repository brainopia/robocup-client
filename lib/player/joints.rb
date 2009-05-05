=begin
Скорость задается в радианах в секунду, что соответствует 57.3 градусам в секунду.
Максимальная скорость поворота – 351.5 градусов в секунду, что соответствует, примерно, 6.15 радианам в секунду
=end

module Player
  attr_reader :structure, :all, :effectors
  
  @degrees_in_radian  = 360 / (Math::PI * 2)
  @average_cycle_time = 0.02 # TODO: make this value adjustable
  
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
      # TODO: remove observer if joint is stuck
      # TODO: restrict max and min angle for each joint
      
      def #{joint}(options=nil, &callback)
        joint         = "#{joint}".to_sym
        effector      = "#{effector}"
        current_angle = data[joint]  
        
        return current_angle      unless options
        raise 'Angle is missing'  unless options[:angle]
        
        angle       = options[:angle]
        max_speed   = options[:speed]       || 6.15
        angle_error = options[:angle_error] || 1
        
        unless equal_with_error? angle, current_angle, angle_error
          add_observer(joint, :manipulator) do |prev_angle, current_angle|            
            if equal_with_error? angle, current_angle, angle_error
              stop joint, &callback
            else
              move effector, estimate_speed(angle, current_angle, max_speed)
            end
          end          
          move effector, estimate_speed(angle, current_angle, max_speed)
          
        else
          stop joint, &callback
        end
      end
CODE

  end
  
  private 
  
  def move(effector, speed)
    commands.push "(#{effector} #{speed})"
  end  
  
  def estimate_speed(angle, current_angle, max_speed)
    angle_difference  = angle - current_angle
    radian_difference = degrees_to_radians(angle_difference) / @average_cycle_time
    direction         = (radian_difference > 0) ? 1 : -1
    
    if radian_difference.abs < max_speed
      radian_difference
    else
      max_speed * direction
    end
  end
  
  def stop(joint, &callback)
    move @effectors[joint], 0
    remove_observer joint, :manipulator
    callback.call if block_given?
  end

  def equal_with_error?(a, b, error)
    (a / error).round == (b / error).round
  end
  
  def radians_to_degrees(radians)
    radians * @degrees_in_radian
  end
  
  def degrees_to_radians(degrees)
    degrees / @degrees_in_radian
  end
end