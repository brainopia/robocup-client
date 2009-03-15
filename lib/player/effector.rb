module Player
  module Joint
    extend self
    
    Names = %w(h1 h2 ll1 rl1 ll2 rl2 ll3 rl3 ll4 rl4 ll5 rl5 ll6 rl6 la1 ra1 la2 ra2 la3 ra3 la4 ra4)
    
    Names.each do |joint|
      define_method joint do |speed|
        Player.commands.push "(#{joint} #{speed})"
      end
    end
    
  end
end
