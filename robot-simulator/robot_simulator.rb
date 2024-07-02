class Robot
  DIRECTIONS = %i[north east south west].freeze

  attr_reader :bearing

  def orient(direction)
    raise ArgumentError unless DIRECTIONS.include?(direction)

    @bearing = direction
  end

  def at(x, y)
    @x = x
    @y = y
  end

  def coordinates
    [@x, @y]
  end

  def turn_right
    rotate(1)
  end

  def turn_left
    rotate(-1)
  end

  def advance
    case @bearing
    when :north
      @y += 1
    when :south
      @y -= 1
    when :east
      @x += 1
    when :west
      @x -= 1
    end
  end

  private

  def rotate(to)
    orient_index = (DIRECTIONS.index(@bearing) + to) % DIRECTIONS.count
    orient(DIRECTIONS[orient_index])
  end
end

class Simulator
  INSTRUCTIONS = {
    L: :turn_left,
    R: :turn_right,
    A: :advance
  }.freeze

  def instructions(letter_string)
    letter_string.chars.map { |c| INSTRUCTIONS[c.to_sym] }
  end

  def place(robot, x: 0, y: 0, direction: :north)
    robot.orient(direction)
    robot.at(x, y)
  end

  def evaluate(robot, letter_string)
    instructions(letter_string).each { |i| robot.send(i) }
  end
end
