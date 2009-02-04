module Player
  module Effector
    extend self
    attr_reader :commands
    @commands = []
    
    def init(team='GOBRAIN', number=0)
      @commands.push "(scene rsg/agent/nao/nao.rsg)", 
                     "(init (unum #{number})(teamname #{team}))"
    end
    
    def joint(name, speed)
      @commands.push "(#{name} #{speed})"
    end
  end # Effector
end # Player
