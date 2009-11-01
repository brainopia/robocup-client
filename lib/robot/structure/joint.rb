# TODO: refactor
module Robot::Structure
  class Joint
    attr_reader :prev_joint, :next_joint,
                :x_axis, :y_axis, :z_axis,
                :translation, :anchor, :orientation,
                :dh_parameters

    def initialize(options)
      @translation = options[:translation] || Vector3d[0,0,0]
      @anchor      = options[:anchor]      || Vector3d[0,0,0]
      @z_axis      = options[:z_axis]      || Vector3d[0,0,1]
      raise 'z-axis should be set as a unit vector' unless @z_axis.unit?
    end

    def bind(next_joint)
      (@next_joint = next_joint).instance_variable_set :@prev_joint, self

      calculate_orientation
      calculate_dh_parameters
    end

    def anchor_translation
      translation + anchor - prev_joint.anchor
    end

    private

    def calculate_dh_parameters
      @dh_parameters = { :a => 0, :alpha => 0, :d => 0, :theta => 0 }

      if prev_joint
        @dh_parameters[:a] = anchor_translation.norm
        @dh_parameters[:alpha] = Math.acos(z_axis.dot_product prev_joint.z_axis) * 180 / Math::PI
        @dh_parameters[:theta] = Math.acos(x_axis.dot_product prev_joint.x_axis) * 180 / Math::PI
      end
    end

    def calculate_orientation
      @x_axis = calculate_x_axis
      @y_axis = @z_axis.cross_product @x_axis
      @orientation = Matrix.columns [@x_axis.to_a, @y_axis.to_a, @z_axis.to_a]
    end

    def calculate_x_axis
      if next_joint
        if next_joint.anchor_translation == Vector3d[0,0,0]
          next_joint.z_axis.cross_product z_axis
        elsif z_axis == next_joint.z_axis
          next_joint.anchor_translation.unit
        else
          # we don't need to handle cases different from crossed and parallel z_axis
          raise "Can't figure out an orientation of frame"
        end
      else
        prev_joint.x_axis
      end
    end
  end
end