class Matrix
  def initialize(string)
    @matrix = string.split("\n").map { |i| i.split.map(&:to_i) }
  end

  def row(number)
    @matrix[number - 1]
  end

  def column(number)
    @matrix.map { |i| i[number - 1] }
  end
end
