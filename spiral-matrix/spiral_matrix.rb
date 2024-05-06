class SpiralMatrix
  def initialize(size)
    @size = size
    @counter = 1
    @direction = %i[right bottom left top]
    @coords = Coordinate.new(0, 0)
    @raw_matrix = Matrix.new(@size)
  end

  def matrix
    render_matrix
  end

  private

  attr_reader :raw_matrix, :counter, :direction, :coords

  def fill_current_position
    raw_matrix.fill_position(coords, counter)
    @counter += 1
  end

  def change_direction_if_necessary
    # very smart! rotating to get proper next direction
    @direction.rotate! unless raw_matrix.fillable?(next_position)
  end

  def move_coords
    @coords = next_position
  end

  def next_position
    coords.move(direction.first)
  end

  def render_matrix
    # raw_matrix.size == 4
    # 4 ** 2 == 16 (the amount of cells in total)
    (raw_matrix.size**2).times do
      fill_current_position
      change_direction_if_necessary
      move_coords
    end

    raw_matrix
  end
end

Coordinate = Struct.new(:x, :y) do
  def move(direction)
    case direction
    when :right then Coordinate.new(x, y + 1)
    when :bottom then Coordinate.new(x + 1, y)
    when :left then Coordinate.new(x, y - 1)
    when :top then Coordinate.new(x - 1, y)
    end
  end
end

class Matrix < Array
  attr_reader :matrix

  def initialize(size)
    @matrix = super(Array.new(size) { Array.new(size, :empty) })
  end

  def content_at(coords)
    matrix[coords.x]&.fetch(coords.y, nil)
  end

  def fill_position(coords, value)
    matrix[coords.x][coords.y] = value
  end

  # empty will mean that next cell is valid to fill
  def fillable?(coords)
    content_at(coords) == :empty
  end
end
