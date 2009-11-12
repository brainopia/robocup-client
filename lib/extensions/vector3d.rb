# TODO: Vector3d < Struct(:x,:y,:z)
class Vector3d
  attr_reader :x,:y,:z

  def self.[](x,y,z)
    new x,y,z
  end

  def initialize(x,y,z)
    @x,@y,@z = x.to_f,y.to_f,z.to_f
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

  def projection(vector)
    vector.unit * dot_product(vector) / vector.norm
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

  def norm
    Math.sqrt x**2 + y**2 + z**2
  end

  def to_a
    [x,y,z]
  end

  def to_s
    to_a.inspect
  end
end