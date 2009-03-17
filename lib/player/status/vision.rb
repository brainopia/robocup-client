module Player::Status::Vision
  extend self
  
  def data
    Player::Status.data[:See]
  end

  def goal1
    values_for :G1L, :G1R
  end

  def goal2
    values_for :G2L, :G2R
  end

  def field
    values_for :F1L, :F2L, :F1R, :F2R
  end

  def ball
    data[:B][:pol]
  end

  private

  def values_for(*objects)
    objects.inject([]) {|values, object| values << data[object][:pol] }
  end
end

module Player::Status
  attr_reader :vision
  @vision = Vision  
end