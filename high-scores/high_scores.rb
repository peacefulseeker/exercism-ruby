class HighScores
  attr_reader :scores

  def initialize(scores)
    @scores = scores
  end

  def latest
    scores.last
  end

  def personal_best
    scores.max
  end

  def personal_top_three
    # @scores.sort { |x, y| y <=> x }.take(3)

    scores.max(3)
  end

  def latest_is_personal_best?
    personal_best == latest
  end
end
