class Vector3d
  attr_reader :x,:y,:z

  def self.zero
    self[0,0,0]
  end

  def self.[](x,y,z)
    new x,y,z
  end

  def initialize(x,y,z)
    @x,@y,@z = x,y,z
  end

  def -@
    Vector3d[-x, -y, -z]
  end

  def +(vector)
    Vector3d[x+vector.x, y+vector.y, z+vector.z]
  end

  def -(vector)
    Vector3d[x-vector.x, y-vector.y, z-vector.z]
  end

  def *(scalar)
    Vector3d[x*scalar, y*scalar, z*scalar]
  end

  def /(scalar)
    Vector3d[x/scalar, y/scalar, z/scalar]
  end

  def dot_product(vector)
    x*vector.x + y*vector.y + z*vector.z
  end

  def scalar_projection(vector)
    dot_product(vector) / vector.norm
  end

  def projection(vector)
    vector.unit * scalar_projection(vector)
  end

  def cross_product(vector)
    Vector3d[y*vector.z - z*vector.y, z*vector.x - x*vector.z, x*vector.y - y*vector.x]
  end

  def ==(vector)
    x==vector.x && y==vector.y && z==vector.z
  end

  def unit
    self / norm
  end

  def unit?
    norm == 1
  end

  def zero?
    self == Vector3d.zero
  end

  def norm
    Math.sqrt x**2 + y**2 + z**2
  end

  def value
    Vector3d[*[x,y,z].map {|it| it.value.default_round }]
  end

  def to_a
    [x,y,z]
  end

  def to_s
    to_a.inspect
  end

  def angle_between(v1, v2)
    plane_direction = v1.cross_product v2
    y_axis = plane_direction.cross_product v1
    x = v2.scalar_projection v1
    y = y_axis.zero? ? 0 : v2.scalar_projection(y_axis)
    sign = (dot_product(plane_direction) >= 0) ? 1 : -1
    sign * Math.atan2(y, x)
  end
end