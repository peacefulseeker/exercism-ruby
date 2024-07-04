class Queens
  def initialize(white: nil, black: nil)
    @white = Queen.new(white) if white
    @black = Queen.new(black) if black
    @board = Array.new(8) { Array.new(8) }
  end

  def attack?
    @white.row == @black.row || @white.col == @black.col || diagonal?
  end

  def diagonal?
    (@white.row - @black.row).abs == (@white.col - @black.col).abs
  end
end

class Queen
  def initialize(coords)
    validate(coords)
    @row = coords[0]
    @col = coords[1]
  end

  attr_reader :row, :col

  def validate(coords)
    raise ArgumentError unless coords.all? { |coord| coord.between?(0, 7) }
  end
end
