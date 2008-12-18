module Player
  class Status    
    class Joints
      
      def initialize(data)
        @data = data[:HJ]
      end
  
      def head
        values_for :hj1, :hj2
      end

      def left_arm
        values_for :laj1, :laj2, :laj3, :laj4
      end
            
      def right_arm
        values_for :raj1, :raj2, :raj3, :raj4
      end
      
      def left_leg
        values_for :llj1, :llj2, :llj3, :llj4, :llj5, :llj6
      end

      def right_leg
        values_for :rlj1, :rlj2, :rlj3, :rlj4, :rlj5, :rlj6
      end
            
      private
      
      def values_for(*joints)
        joints.inject([]) {|values, joint| values << @data[joint][:ax] }
      end
    end # Joints
  end # Status
end # Player