require 'app/grid'

class Game
  attr_accessor :grid

  def self.start_with_data(data)
    new Grid.from_data(data)
  end

  def initialize(grid)
    @grid = grid
  end

  def iterate(count)
    # removing if-statement from recursion
    (count > 0 && self.class.new(grid.evolve).iterate(count-1)) || self
  end

  def result
    @grid.to_s
  end
end
