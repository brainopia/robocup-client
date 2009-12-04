class Robot::Structure::Joint
  class DSL
    attr_reader :anchor_translation, :z_axis, :x_axis, :full_translation, :full_transformation

    def initialize(side, &proc)
      @side        = side
      @translation = Vector3d[0,0,0]
      @anchor      = Vector3d[0,0,0]
      @z_axis      = Vector3d[0,0,1]

      instance_eval &proc
    end

    def instance
      Robot::Structure::Joint.new @perceptor, @full_transformation
    end

    def axis(x,y,z)
      @z_axis = Vector3d[x,y,z].unit
    end

    def translation(x,y,z)
      @translation = Vector3d[x,y,z]
    end

    def anchor(*args)
      return @anchor if args.empty?
      @anchor = Vector3d[*args]
    end

    def perceptor(value)
      @perceptor = :"#{side_shortcut}#{value}"
    end

    def side_shortcut
      case @side
      when :right then 'r'
      when :left then 'l'
      end
    end

    def bind(prev_joint, next_joint, index)
      @prev = prev_joint
      @next = next_joint
      @index = index
    end

    def calculate_anchor_translation
      @anchor_translation = @translation + @anchor - (@prev ? @prev.anchor : Vector3d.zero)
    end

    def calculate_full_translation
      @full_translation = @anchor_translation + (@prev ? @prev.full_translation : Vector3d.zero)
    end

    def calculate_orientation
      @x_axis = calculate_x_axis
      @y_axis = @z_axis.cross_product @x_axis
      @orientation = Matrix.columns [@x_axis.to_a, @y_axis.to_a, @z_axis.to_a]
    end

    def calculate_x_axis
      if @next
        if @next.anchor_translation == Vector3d.zero # next and current joints have the same origin
          @next.z_axis.cross_product @z_axis
        elsif @z_axis == @next.z_axis # next and current joints have parallel z-axis
          if @next.anchor_translation.unit.dot_product(@z_axis) != 0
            raise 'Anchor translation is not perpendecular to z-axis, this case is not implemented'
          else
            @next.anchor_translation.unit
          end
        else
          perpendicular = @z_axis.cross_product @next.anchor_translation
          if @next.z_axis.dot_product(perpendicular) == 0
            # case when z_axis and next z_axis lie in one plane so they're crossed
            @next.z_axis.cross_product @z_axis
          else
            # we don't need to handle cases different from crossed and parallel z_axis
            raise "Can't figure out an orientation of frame"
          end
        end
      else # if it's the last joint then we'll use x-axis from previous joint
        @prev.x_axis
      end
    end

    def calculate_dh_parameters
      @dh_parameters = { :a => 0, :alpha => 0, :d => 0, :theta => 0 }

      if @prev
        if @prev.z_axis == @z_axis
           # only for case when anchor_translation is perpendecular to z-axis
          @dh_parameters[:a] = @anchor_translation.norm.default_round
        elsif @anchor_translation != Vector3d.zero
          # we're handling here only a subset of cases, which is enough for us
          @dh_parameters[:d] = @anchor_translation.projection(@z_axis).norm.default_round
        end
        @dh_parameters[:alpha] = @prev.x_axis.angle_between(@prev.z_axis, @z_axis).radians.default_round
        @dh_parameters[:theta] = @z_axis.angle_between(@prev.x_axis, @x_axis).radians.default_round
      end

      if @next && @next.anchor_translation != Vector3d.zero
        # we're handling here only a subset of cases, which is enough for us
        @dh_parameters[:d] += @next.anchor_translation.projection(@z_axis).norm.default_round
      end

      symbolic do
        # TODO: make var { data } work with the same var across whole matrix and raise if var is nil
        @dh_parameters[:theta] += var(:name => "θ#{@index}") { Robot.data[@perceptor] }
      end
    end

    def calculate_transformation
      alpha = @dh_parameters[:alpha].degrees
      a = @dh_parameters[:a]
      theta = @dh_parameters[:theta].degrees
      d = @dh_parameters[:d]
      x_rotation = Transformation.rotate_around(:x, alpha)
      x_translation = Transformation.move_along(:x, a)
      z_translation = Transformation.move_along(:z, d)

      symbolic do
        z_rotation = Transformation.rotate_around(:z, theta)
        @transformation = x_rotation * x_translation * z_rotation * z_translation
        @full_transformation = if @prev
          @prev.full_transformation * @transformation
        else
          orientation = [@x_axis.to_a, @y_axis.to_a, @z_axis.to_a]
          initial_transformation = Matrix.columns(orientation.map {|it| it << 0.0 } << (@anchor_translation.to_a << 1))
          Transformation.new(initial_transformation) * @transformation
        end
      end
    end

  end
end