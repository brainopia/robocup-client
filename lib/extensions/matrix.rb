class Matrix
  def value
    map {|it| it.value.default_round }
  end
end