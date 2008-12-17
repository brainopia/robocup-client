module Player
  class Status
    class Vision
      
      def initialize(data)
        @data = data[:See]
      end
      
      def g1l
        @data[:G1L][:pol]
      end
    
      def g2l
        @data[:G2L][:pol]
      end
    
      def g1r
        @data[:G1R][:pol]
      end
    
      def g2r
        @data[:G2R][:pol]
      end
    
      def f1l
        @data[:F1L][:pol]
      end

      def f2l
        @data[:F2L][:pol]
      end

      def f1r
        @data[:F1R][:pol]
      end

      def f2r
        @data[:F2R][:pol]
      end

      def ball
        @data[:B][:pol]
      end
      
    end # Vision
  end # Status
end # Player