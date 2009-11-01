module Robot::Structure
  @joints, @limbs = {}, {}

  class << self
    attr_reader :joints, :limbs

    private

    def symmetrical_joint(name, &proc)
      [:left, :right].each do |side|
        joint :"#{side}_#{name}", side, &proc
      end
    end

    def joint(name, side=nil, &proc)
      @joints[name] = JointDSL.new(side, &proc).joint
    end

    def symmetrical_limb(*args)
      [:left, :right].each do |side|
        limb *args.map {|it| :"#{side}_#{it}" }
      end
    end

    def limb(name, *joints)
      @limbs[name] = Limb.new joints.map {|name| @joints[name] }
    end
  end
end