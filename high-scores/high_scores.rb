class HighScores
  attr_reader :scores, :latest, :personal_best

  def initialize(scores)
    @scores = scores
    @latest = scores.last
    @personal_best = @scores.max
  end

  def personal_top_three
    @scores.sort { |x, y| y <=> x }.take(3)
  end

  def latest_is_personal_best?
    @personal_best == @latest
  end
end
