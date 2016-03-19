require './app/cell'

class Grid
  CELL_DELIMETER = " "
  LINES_DELIMETER = "\n"
  HEADER_FOOTER_LINE = "```"

  def self.from_data(data)
    new create_cells_from_data(data)
  end

  def initialize(cells)
    @cells = cells
  end

  def evolve
    self.class.new(regenerate_cells_from_map(survided_cells.merge spawned_cells))
  end

  def to_s
    [
      HEADER_FOOTER_LINE,
      @cells.map { |line| line.map(&:to_i).join(CELL_DELIMETER) },
      HEADER_FOOTER_LINE
    ].join(LINES_DELIMETER) << LINES_DELIMETER
  end

  private

  def self.create_cells_from_data(data)
    data.lines[1..-2].each_with_index.map do |line, y|
      line.chomp.split(CELL_DELIMETER).collect(&:strip).each_with_index.map do |item, x|
        Cell.new(item == "1", x, y)
      end
    end
  end

  def regenerate_cells_from_map(map)
    (0..height-1).map do |y|
      (0..width-1).map do |x|
        Cell.new(!map[[x, y]].nil?, x, y)
      end
    end
  end

  def survided_cells
    cells_map.select do |coordinate, live|
      # if there are 3 neighbors cell will be spawned anyway
      live && neighbors_map[coordinate] == 2
    end
  end

  def spawned_cells
    neighbors_map.select { |_, neighbors_count| neighbors_count == 3 }
  end

  def cells_map
    # just a variable caching, not mutating
    @cells_map ||= Hash[
      @cells.each_with_index.map do |line, y|
        line.each_with_index.map do |cell, x|
          [ [x, y], cell.live? ]
        end
      end.flatten(1)
    ]
  end

  def neighbors_map
    # just a variable caching, not mutating
    @neighbors_map ||= Hash[
      @cells.each_with_index.map do |line, y|
        line.each_with_index.map do |_, x|
          [ [x, y], neightborhood_cells(x, y).count { |neighbor| neighbor.live? } ]
        end
      end.flatten(1)
    ]
  end

  def width
    @cells[0].size
  rescue
    0
  end

  def height
    @cells.size
  end

  def neightborhood_cells(x, y)
    neighbors(x, y).map do |coordinate|
      fetch_cell(coordinate)
    end
  end

  def neighbors(x, y)
    [
      [[x-1, 0].max,       [y-1, 0].max],
      [ x,                 [y-1, 0].max],
      [[x+1, width-1].min, [y-1, 0].max],
      [[x-1, 0].max,        y],
      [[x+1, width-1].min,  y],
      [[x-1, 0].max,       [y+1, height-1].min],
      [x,                  [y+1, height-1].min],
      [[x+1, width-1].min, [y+1, height-1].min]
    ]
      .uniq
      .reject { |_x, _y| _x == x && _y ==y }
  end

  def fetch_cell(coordinate)
    @cells[coordinate[1]][coordinate[0]]
  end
end
