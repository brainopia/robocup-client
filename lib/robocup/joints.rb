module Robocup
  module Joints
    extend self    
    attr_reader :structure, :all, :effectors, :perceptors
    
    @structure = { 
      :head       => %w(h1 h2),
      :left_arm   => %w(la1 la2 la3 la4),
      :right_arm  => %w(ra1 ra2 ra3 ra4),
      :left_leg   => %w(ll1 ll2 ll3 ll4 ll5 ll6),
      :right_leg  => %w(rl1 rl2 rl3 rl4 rl5 rl6)
    }
    
    @all = @structure.values.flatten
    
    def convert_to_perceptor(joint)
      joint.sub /(\D*)(\d)/, '\1j\2'
    end
    
    def convert_to_effector(joint)
      joint.sub /(\D*)(\d)/, '\1e\2'
    end
        
    @effectors  = @all.inject({}) {|it, joint| it[joint] = convert_to_effector(joint);  it }
    @perceptors = @all.inject({}) {|it, joint| it[joint] = convert_to_perceptor(joint); it }
  end
end