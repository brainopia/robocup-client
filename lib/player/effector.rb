module Player
  module Effector
    extend self
    
    def init(team='GOBRAIN', number=0)
      "(scene rsg/agent/nao/nao.rsg)" +
      "(init (unum #{number})(teamname #{team}))"
    end
    
    def joint(name, angle)
      "(#{name} #{angle})"
    end
  end # Effector
end # Player
