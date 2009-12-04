module Robot::Structure
  class Limb
    class DSL
      def initialize(side, &proc)
        @side, @joints = side, []
        instance_eval &proc
        bind and calculate
      end

      def instance
        Limb.new @joints.map(&:instance)
      end

      def joint(name, &proc)
        @joints << Joint::DSL.new(@side, &proc)
      end

      def right_side?
        @side == :right
      end

      def bind
        @joints.each_with_index do |joint, index|
          prev_joint = (index == 0) ? nil : @joints[index-1]
          next_joint = @joints[index+1]

          joint.bind prev_joint, next_joint, index
        end
      end

      def calculate
        [:calculate_anchor_translation, :calculate_full_translation,
         :calculate_orientation, :calculate_dh_parameters,
         :calculate_transformation].each do |method|
           @joints.each &method
        end
      end

    end # DSL
  end # Limb
end # Robot::Structure