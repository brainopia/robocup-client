module Robot::Structure
  symmetrical_joint :hip1 do
    sign = right_side? ? 1 : -1

    translation sign*0.055, -0.01, -0.115
    axis -0.7071, 0, sign*0.7071
  end

  symmetrical_joint :hip2 do
    axis 0, 1, 0
  end

  symmetrical_joint :thigh do
    translation 0, 0.01, -0.04
    anchor 0, -0.01, 0.04
    axis 1, 0, 0
  end

  symmetrical_joint :shank do
    translation 0, 0.005, -0.125
    anchor 0, -0.01, 0.045
    axis 1, 0, 0
  end

  symmetrical_joint :ankle do
    translation 0, -0.01, -0.055
    axis 1, 0, 0
  end

  symmetrical_joint :foot do
    translation 0, 0.03, -0.035
    anchor 0, -0.03, 0.035
    axis 0, 1, 0
  end

  symmetrical_limb :leg, :hip1, :hip2, :thigh, :shank, :ankle, :foot
end