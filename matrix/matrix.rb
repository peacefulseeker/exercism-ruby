class Matrix
  def initialize(string)
    # @matrix = string.split("\n").map { |i| i.split.map(&:to_i) }

    @matrix = string.lines.map { |line| line.split.map(&:to_i) }
  end

  def row(position)
    @matrix[position - 1]
  end

  def column(position)
    @matrix.map { |row| row[position - 1] }
  end
end
