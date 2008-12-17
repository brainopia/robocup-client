module Player
  class Status
    class Force
      
      def initialize(data)
        @data = data[:FRP]
      end
      
      def rf
        @data[:rf]
      end
      
      def lf
        @data[:lf]
      end

    end # ForceResistance
  end # Status
end # Player