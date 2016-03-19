class Cell
  attr_accessor :value, :x, :y

  def initialize(value, x, y)
    @value, @x, @y = value, x, y
  end

  def live?
    value
  end

  def to_i
    # just a funny trick to avoid if-statement
    value && 1 || 0
  end
end
