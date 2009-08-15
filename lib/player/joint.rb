require 'yaml'
=begin
Скорость задается в радианах в секунду, что соответствует 57.3 градусам в секунду.
Максимальная скорость поворота – 351.5 градусов в секунду, что соответствует, примерно, 6.15 радианам в секунду
=end

module Robot
  # TODO: take in account an inertia when calculate an anguliar speed for a joint!!!!
  class Joint
    silence_warnings do
      MaxSpeed          = 6.15
      DefaultError      = 1
      DegreesInRadian   = 180 / Math::PI
      AverageCycleTime  = 0.02 # TODO: make this value adjustable (very important! it can drastically change quality of movements if the cycle time will be changed)
      Angles            = YAML.load_file 'lib/player/joint/angles.yml'
      HistoryDepth      = 10
    
      Structure = { 
        :head       => [:h1, :h2],
        :left_arm   => [:la1, :la2, :la3, :la4],
        :right_arm  => [:ra1, :ra2, :ra3, :ra4],
        :left_leg   => [:ll1, :ll2, :ll3, :ll4, :ll5, :ll6],
        :right_leg  => [:rl1, :rl2, :rl3, :rl4, :rl5, :rl6]
      }
    end
    
    attr_reader :destination_angle, :speed, :history, :max_speed, :error, :name
    
    def initialize(joint)
      @name     = joint
      @effector = effector_from_name
      @angles   = Angles[joint]
      @history  = []
    end
    
    def current_angle
      Robot.data[@name]
    end
    
    def destination_angle=(angle)
      raise "Angle is missing" unless angle
      raise "Angle #{angle} doesn't belong to a range of acceptable values #{@angles}" unless @angles.include? angle
      @destination_angle = angle.to_f
    end
    
    def max_speed=(given_speed)
      given_speed ||= MaxSpeed
      raise "Max speed should be positive" unless given_speed > 0
      raise "Speed #{value} exceeds max speed #{MaxSpeed}" if given_speed > MaxSpeed
      @max_speed = given_speed
    end
    
    def error=(given_error)
      @error = given_error || DefaultError
    end
    
    def move(options, &callback)
      self.destination_angle  = options[:angle]
      self.max_speed          = options[:speed]
      self.error              = options[:error]
      @callback               = callback

      if reached_destination?
        stop
      else
        sync_speed
        Robot.observers[@name] = lambda do
          update_history
          (reached_destination? or stuck?) ? stop : sync_speed
        end
      end
    end
    
    def stop
      Robot.observers.delete @name
      @destination_angle = nil
      sync_speed
      @callback.call if @callback      
    end
    
    def angle_difference
      @destination_angle - current_angle
    end
          
    def radian_difference
      degrees_to_radians angle_difference
    end
    
    def direction
      (radian_difference > 0) ? 1 : -1
    end
        
    private
    
    def update_history      
      @history.shift if @history.size == HistoryDepth
      @history << current_angle
    end
    
    def reached_destination?
      (current_angle / @error).round == (@destination_angle / @error).round
    end
    
    def stuck?
      history.size / 2.0 > history.uniq.size
    end
    
    def effector_from_name
      # конвертируем название cустава в название эффектора (к примеру, h1 к he1)
      @name.to_s.sub /(\D*)(\d)/, '\1e\2'
    end
    
    def sync_speed
      @speed = estimate_speed
      Robot.commands << "(#{@effector} #{@speed})"
    end
    
    def estimate_speed
      # TODO: take in account inertia of joint
      return 0 unless @destination_angle
            
      speed = speed_to_achive_destination_angle_in_one_cycle
      
      if speed.abs < @max_speed
        speed / 3 # temporarily solution to an inertia component
      else
        @max_speed * direction
      end
    end
    
    def speed_to_achive_destination_angle_in_one_cycle
      radian_difference / AverageCycleTime
    end
    
    def radians_to_degrees(radians)
      radians * DegreesInRadian
    end

    def degrees_to_radians(degrees)
      degrees / DegreesInRadian
    end
  end # Joint
  
  attr_reader :joints
  
  @joints = Joint::Structure.values.flatten.inject({}) do |joints, joint_name|
    joints[joint_name] = Joint.new joint_name
    joints
  end
  
  @joints.each do |joint_name, joint|
    define_method "#{joint_name}=" do |angle|
      joint.move :angle => angle
    end

    eval <<-CODE      
      def #{joint_name}(options=nil, &callback)
        joint = @joints["#{joint_name}".to_sym]
      
        return joint.current_angle unless options
        joint.move options, &callback
      end
    CODE

  end # @joints.each
end # Robot