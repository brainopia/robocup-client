class Numeric
  def degrees
    self * (Math::PI / 180)
  end

  def radians
    self * (180 / Math::PI)
  end

  def round_to(degree)
    (self * 10**degree).round.to_f / 10**degree
  end
end