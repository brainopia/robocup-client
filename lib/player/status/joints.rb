module Player::Status::Joints
  extend self
  
  Robocup::Joints.structure.each do |limb, joints|    
    perceptors = joints.map {|joint| Robocup::Joints.perceptors[joint] }
    
    define_method limb do
      values_for perceptors
    end
    
    joints.each do |joint|
      define_method joint do
        value_for Robocup::Joints.perceptors[joint]
      end
    end
  end
  
  def data
    Player::Status.data[:HJ]
  end
        
  private
  
  def value_for(joint)
    data[joint.to_sym][:ax]
  end
  
  def values_for(joints)
    joints.inject([]) {|values, joint| values << value_for(joint) }
  end
end

module Player::Status
  attr_reader :joints
  @joints = Joints
end