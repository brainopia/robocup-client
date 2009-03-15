module Player::Status::Force
  extend self
  
  def data
    Player::Status.data[:FRP]
  end

  def right_foot
    data[:rf]
  end
  
  def left_foot
    data[:lf]
  end
end

module Player::Status
  attr_reader :force
  @force = Force
end