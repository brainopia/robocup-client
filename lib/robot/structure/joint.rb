# coding: utf-8
# TODO: refactor
module Robot::Structure
  class Joint
    attr_reader :transformation

    def initialize(perceptor, transformation)
      @perceptor = perceptor
      @transformation = transformation
    end

    def current_angle
      Robot.data[@perceptor]
    end

    def debug
      puts "perceptor: #{@perceptor}"
      puts "translation: #{@transformation.translation.value}"
      puts "rotation: #{@transformation.rotation.value.column_vectors.join ', '}"
      puts "\n\n"
    end
  end
end