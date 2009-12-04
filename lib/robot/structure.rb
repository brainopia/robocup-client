module Robot::Structure
  @limbs = {}

  class << self
    attr_reader :limbs

    def symmetrical_limb(name, &proc)
      [:left, :right].each {|side| limb :"#{side}_#{name}", side, &proc }
    end

    def limb(name, side=nil, &proc)
      @limbs[name] = Limb::DSL.new(side, &proc).instance
    end
  end

  symmetrical_limb :leg do
    sign = right_side? ? 1 : -1

    joint :hip1 do
      perceptor :l1
      translation sign*0.055, -0.01, -0.115
      axis -0.7071, 0, sign*0.7071
    end

    joint :hip2 do
      perceptor :l2
      axis 0, 1, 0
    end

    joint :thigh do
      perceptor :l3
      translation 0, 0.01, -0.04
      anchor 0, -0.01, 0.04
      axis 1, 0, 0
    end

    joint :shank do
      perceptor :l4
      translation 0, 0.005, -0.125
      anchor 0, -0.01, 0.045
      axis 1, 0, 0
    end

    joint :ankle do
      perceptor :l5
      translation 0, -0.01, -0.055
      axis 1, 0, 0
    end

    joint :foot do
      perceptor :l6
      translation 0, 0.03, -0.035
      anchor 0, -0.03, 0.035
      axis 0, 1, 0
    end
  end

  symmetrical_limb :arm do
    sign = right_side? ? 1 : -1

    joint :shoulder do
      perceptor :a1
      translation sign*0.098, 0, 0.075
      axis 1, 0, 0
    end

    joint :upperarm do
      perceptor :a2
      translation sign*0.01, 0.02, 0
      anchor -sign*0.01, -0.02, 0
      axis 0, 0, 1
    end

    joint :elbow do
      perceptor :a3
      translation -sign*0.01, 0.07, 0.009
      axis 0, 1, 0
    end

    joint :lowerarm do
      perceptor :a4
      translation 0, 0.05, 0
      anchor 0, -0.05, 0
      axis 0, 0, 1
    end
  end
end