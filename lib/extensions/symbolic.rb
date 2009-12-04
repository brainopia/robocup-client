class Symbolic::Operatable
  def degrees
    self / Numeric::DEGREES_IN_RADIANS
  end

  def radians
    self * Numeric::DEGREES_IN_RADIANS
  end
end