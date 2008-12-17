module Player
  class Status    
    class Joints
      
      def initialize(data)
        @data = data[:HJ]
      end
  
      def h1
        @data[:hj1][:ax]
      end

      def h2
        @data[:hj2][:ax]
      end
  
      def la1
        @data[:laj1][:ax]
      end
      
      def la2
        @data[:laj2][:ax]
      end
      
      def la3
        @data[:laj3][:ax]
      end
      
      def la4
        @data[:laj4][:ax]
      end
      
      def ra1
        @data[:raj1][:ax]
      end
      
      def ra2
        @data[:raj2][:ax]
      end
      
      def ra3
        @data[:raj3][:ax]
      end
      
      def ra4
        @data[:raj4][:ax]
      end
      
      def ll1
        @data[:llj1][:ax]
      end
      
      def ll2
        @data[:llj2][:ax]
      end
      
      def ll3
        @data[:llj3][:ax]
      end
      
      def ll4
        @data[:llj4][:ax]
      end

      def ll5
        @data[:llj5][:ax]
      end
      
      def ll6
        @data[:llj6][:ax]
      end
      
      def rl1
        @data[:rlj1][:ax]
      end
      
      def rl2
        @data[:rlj2][:ax]
      end
      
      def rl3
        @data[:rlj3][:ax]
      end
      
      def rl4
        @data[:rlj4][:ax]
      end

      def rl5
        @data[:rlj5][:ax]
      end
      
      def rl6
        @data[:rlj6][:ax]
      end
      
    end # Joints
  end # Status
end # Player