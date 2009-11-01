module Robot::Structure
  class JointDSL
    def initialize(side, &proc)
      @side, @options = side, {}
      instance_eval &proc
    end

    def joint
      Robot::Structure::Joint.new @options
    end

    def axis(x,y,z)
      @options[:z_axis] = Vector3d[x,y,z].unit
    end

    def translation(x,y,z)
      @options[:translation] = Vector3d[x,y,z]
    end

    def anchor(x,y,z)
      @options[:anchor] = Vector3d[x,y,z]
    end

    def right_side?
      @side == :right
    end

    def left_side?
      @side == :left
    end
  end
end