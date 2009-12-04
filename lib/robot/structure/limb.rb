module Robot::Structure
  class Limb
    attr_reader :joints

    def initialize(joints)
      @joints = joints
    end
  end
end