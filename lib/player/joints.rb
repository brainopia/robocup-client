module Player
  module Joints

    @structure = { 
      :head       => %w(h1 h2),
      :left_arm   => %w(la1 la2 la3 la4),
      :right_arm  => %w(ra1 ra2 ra3 ra4),
      :left_leg   => %w(ll1 ll2 ll3 ll4 ll5 ll6),
      :right_leg  => %w(rl1 rl2 rl3 rl4 rl5 rl6)
    }
    
    @all = @structure.values.flatten

    @effectors = @all.inject({}) do |effectors, joint|
      effectors[joint] = joint.sub /(\D*)(\d)/, '\1e\2' # convert joint to effector (eg, from h1 to he1)
      effectors
    end
    
    @effectors.each do |joint, effector|
      define_method "#{joint}=" do |speed|
        commands.push "(#{effector} #{speed})"
      end
      
      define_method joint do
        data[joint.to_sym]
      end
    end
    
  end
end