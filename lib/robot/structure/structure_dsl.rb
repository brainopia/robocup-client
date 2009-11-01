module Robot::Structure
  @joints, @limbs = {}, {}

  private

  def self.symmetrical_joint(name, &proc)
    [:left, :right].each do |side|
      joint :"#{side}_#{name}", side, &proc
    end
  end

  def self.joint(name, side=nil, &proc)
    @joints[name] = JointDSL.new(side, &proc).joint
  end

  def self.symmetrical_limb(*args)
    [:left, :right].each do |side|
      limb *args.map {|it| :"#{side}_#{it}" }
    end
  end

  def self.limb(name, *joints)
    @limbs[name] = Limb.new joints.map {|name| @joints[name] }
  end
end