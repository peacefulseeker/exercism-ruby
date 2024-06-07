class Darts
  OUTER_MAX = 7 + 7
  MIDDLE_MAX = 3.5 + 3.5
  INNER_MAX = 0.7 + 0.7

  # order matters
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

# https://exercism.org/tracks/ruby/exercises/darts/solutions/burennto
# thinking @distance as square root of sum of coord powers...
class DartsMath
  def initialize(x, y)
    @distance = Math.sqrt(x**2 + y**2)
    # @distance = Math.hypot(x, y) # same as above
  end

  def score
    case @distance
    when 0..1 then 10
    when 1..5 then 5
    when 5..10 then 1
    else 0
    end
  end
end

# https://exercism.org/tracks/ruby/exercises/darts/solutions/jhass
# comparing coords square roots with radius
DartsStruct = Struct.new(:x, :y) do
  INNER_RADIUS  =  1
  MIDDLE_RADIUS =  5
  OUTER_RADIUS  = 10

  def score
    return 10 if inside_circle?(INNER_RADIUS, x, y)
    return 5 if inside_circle?(MIDDLE_RADIUS, x, y)
    return 1 if inside_circle?(OUTER_RADIUS, x, y)

    0
  end

  private

  def inside_circle?(r, x, y)
    x**2 + y**2 <= r**2
  end
end
