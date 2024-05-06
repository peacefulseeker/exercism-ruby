# https://exercism.org/tracks/ruby/exercises/spiral-matrix/solutions/jchunky

class Matrix < Struct.new(:size)
  attr_reader :matrix

  def initialize(size)
    super(size)
    @matrix = Array.new(size) { Array.new(size) { :empty } }
  end

  def fill_position(coordinate, value)
    matrix[coordinate.y][coordinate.x] = value
  end

  def empty?(position)
    content_at(position) == :empty
  end

  def to_a
    @matrix
  end

  private

  def content_at(coordinate)
    matrix[coordinate.y]&.fetch(coordinate.x, nil)
  end
end

class Coordinate < Struct.new(:x, :y)
  def move(direction)
    case direction
    when :east then Coordinate.new(x + 1, y + 0)
    when :south then Coordinate.new(x + 0, y + 1)
    when :west then Coordinate.new(x - 1, y + 0)
    when :north then Coordinate.new(x + 0, y - 1)
    end
  end
end

class SpiralMatrix
  attr_reader :raw_matrix, :count, :direction, :position

  def initialize(size)
    @raw_matrix = Matrix.new(size)
    @count = 1
    @direction = %i[east south west north]
    @position = Coordinate.new(0, 0)

    populate_matrix
  end

  def matrix
    raw_matrix.to_a
  end

  private

  def populate_matrix
    (raw_matrix.size**2).times do
      fill_current_position
      change_direction_if_necessary
      walk
    end
  end

  def fill_current_position
    raw_matrix.fill_position(position, count)
    @count += 1
  end

  def change_direction_if_necessary
    direction.rotate! unless raw_matrix.empty?(next_position)
  end

  def walk
    @position = next_position
  end

  def next_position
    position.move(direction.first)
  end
end
