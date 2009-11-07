# coding: utf-8
# TODO: refactor
module Robot::Structure
  class Joint
    attr_reader :prev_joint, :next_joint,
                :x_axis, :y_axis, :z_axis,
                :translation, :anchor, :orientation,
                :dh_parameters, :transformation,
                :full_transformation

    def initialize(options)
      @translation = options[:translation] || Vector3d[0,0,0]
      @anchor      = options[:anchor]      || Vector3d[0,0,0]
      @z_axis      = options[:z_axis]      || Vector3d[0,0,1]
      @perceptor   = options[:perceptor]
      raise 'z-axis should be set as a unit vector' unless @z_axis.unit?
    end

    def bind(next_joint)
      (@next_joint = next_joint).instance_variable_set :@prev_joint, self

      calculate_orientation
      calculate_dh_parameters
      calculate_transformation
      # debug
    end

    def anchor_translation
      translation + anchor - prev_joint.anchor
    end

    def current_angle
      Robot.data[@perceptor]
    end

    def current_transformation
      @theta.value = current_angle
      @transformation.map {|it| it.is_a?(Symbolic::Operatable) ? it.value : it }
    end

    def current_full_transformation
      if prev_joint
        prev_joint.current_full_transformation * current_transformation
      else
        current_transformation
      end
    end

    private

    def debug
      puts "index: #{index}"
      @dh_parameters.each {|k, v| puts "#{k}: #{v}, "}
      puts "x rotation: #{@x_rotation}"
      puts "x translation: #{@x_translation}"
      puts "z rotation: #{@z_rotation}"
      puts "transformation: #{@transformation}"
      puts "full transformation: #{@full_transformation}"
      puts "\n\n"
    end

    def calculate_transformation
      alpha = @dh_parameters[:alpha].degrees
      a = @dh_parameters[:a]
      theta = @dh_parameters[:theta]
      symbolic do
        @x_rotation = Matrix[[1, 0, 0, 0],
                            [0, Math.cos(alpha).round_to(4), -Math.sin(alpha).round_to(4), 0],
                            [0, Math.sin(alpha).round_to(4), Math.cos(alpha).round_to(4), 0],
                            [0, 0, 0, 1]]

        @x_translation = Matrix[[1, 0, 0, a],
                               [0, 1, 0, 0],
                               [0, 0, 1, 0],
                               [0, 0, 0, 1]]

        @z_rotation = Matrix[[Math.cos(theta), -Math.sin(theta), 0, 0],
                            [Math.sin(theta), Math.cos(theta), 0, 0],
                            [0, 0, 1, 0],
                            [0, 0, 0, 1]]
        @transformation = @x_rotation * @x_translation * @z_rotation
        @full_transformation = if prev_joint
          prev_joint.full_transformation * @transformation
        else
          @transformation
        end
      end
    end

    def calculate_dh_parameters
      @dh_parameters = { :a => 0, :alpha => 0, :d => 0, :theta => 0 }

      if prev_joint
        @dh_parameters[:a] = anchor_translation.norm.round_to(4)
        @dh_parameters[:alpha] = Math.acos(z_axis.dot_product prev_joint.z_axis).radians.round_to(4)
        @dh_parameters[:theta] = Math.acos(x_axis.dot_product prev_joint.x_axis).radians.round_to(4)
      end

      @theta = var :name => "θ#{index}"
      symbolic do
        @dh_parameters[:theta] += @theta
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

    def index
      joint, index = self, 0
      index += 1 while joint = joint.prev_joint
      index
    end
  end
end