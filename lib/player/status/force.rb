module Player
  class Status
    class Force
      
      def initialize(data)
        @data = data[:FRP]
      end
      
      def right_foot
        @data[:rf]
      end
      
      def left_foot
        @data[:lf]
      end

    end # ForceResistance
  end # Status
end # Player