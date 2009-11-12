module Robot::Structure
  class Limb
    attr_reader :joints

    def initialize(joints)
      bind joints
    end

    private

    def bind(joints)
      @joints = joints.each_with_index do |joint, index|
        joint.bind joints[index+1]
      end
    end
  end
end