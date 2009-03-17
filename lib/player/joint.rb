module Player
  module Joint
    extend self
    
    Robocup::Joints.effectors.each do |joint, effector|
      define_method joint do |options|
        options ||= {}
        # options = { :position => options } if options.is_a? Number
        speed = options[:speed] || 0
        
        # unless options[:position]          
          Player.commands.push "(#{effector} #{speed})"
        # else
          
        # end
      end
    end
    
  end
end
