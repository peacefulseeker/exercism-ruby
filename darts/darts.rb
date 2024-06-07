class Darts
  OUTER_MAX = 14
  MIDDLE_MAX = 7
  INNER_MAX = 1.4

  SCORES = {
    INNER_MAX => 10,
    MIDDLE_MAX => 5,
    OUTER_MAX => 1
  }
  def initialize(x, y)
    @coords_sum = x.abs + y.abs
  end

  def score
    SCORES.find { |score_max, _| @coords_sum <= score_max }&.fetch(1) || 0
  end
end
