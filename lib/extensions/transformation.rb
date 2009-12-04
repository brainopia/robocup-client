class Transformation
  attr_reader :matrix

  def self.from_rotation(matrix)
    new Matrix.rows matrix.to_a.map {|row| row << 0 } << [0, 0, 0, 1]
  end

  def self.from_translation(vector)
    new Matrix.rows Matrix.identity(3).to_a.zip(vector.to_a).map {|r,t| r << t } << [0, 0, 0, 1]
  end

  def self.rotate_around(axis, angle)
    cos, sin = Math.cos(angle), Math.sin(angle)
    cos, sin = cos.default_round, sin.default_round unless angle.symbolic?

    matrix = case axis
    when :x
      Matrix[[1, 0, 0], [0, cos, -sin], [0, sin, cos]]
    when :y
      Matrix[[cos, 0, sin], [0, 1, 0], [-sin, 0, cos]]
    when :z
      Matrix[[cos, -sin, 0], [sin, cos, 0], [0, 0, 1]]
    else
      raise 'Unknown axis'
    end

    from_rotation matrix
  end

  def self.move_along(axis, distance)
    vector = case axis
    when :x
      Vector3d[distance, 0, 0]
    when :y
      Vector3d[0, distance, 0]
    when :z
      Vector3d[0, 0, distance]
    else
      raise 'Unknown axis'
    end

    from_translation vector
  end

  def initialize(matrix=nil)
    @matrix = matrix || Matrix.identity(4)
  end

  def *(transformation)
    Transformation.new self.matrix*transformation.matrix
  end

  def rotation
    @matrix.minor 0..2, 0..2
  end

  def translation
    Vector3d[@matrix[0,3],@matrix[1,3],@matrix[2,3]]
  end

  def map(&proc)
    Transformation.new matrix.map(&proc)
  end
end