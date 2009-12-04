class Numeric
  DEGREES_IN_RADIANS = 180 / Math::PI
  ROUND_DEGREE = 4

  def degrees
    self / DEGREES_IN_RADIANS
  end

  def radians
    self * DEGREES_IN_RADIANS
  end

  def round_to(degree)
    (self * 10**degree).round.to_f / 10**degree
  end

  def default_round
    ROUND_DEGREE ? round_to(ROUND_DEGREE) : self
  end
end