class Game
  class BowlingError < StandardError; end

  BONUS_BALLS_AFTER_STRIKE = 2
  BONUS_BALLS_AFTER_SPARE = 1

  def initialize
    @frames = []
    @frames_allowance = 10
  end

  def roll(pins)
    last_frame = @frames[@frames.size - 1]
    frame_before_last = @frames[@frames.size - 2]
    raise Game::BowlingError unless pins.between?(0, 10)
    raise Game::BowlingError if @frames.size >= @frames_allowance && frame_completed?(last_frame)
    if bonus_roll? && (
      (frame_completed?(last_frame) && !strike?(last_frame) && !spare?(last_frame)) ||
         (spare?(frame_before_last) && !frame_completed?(last_frame)) ||
         (strike?(frame_before_last) && last_frame[0] != 10 && pins == 10)
    )
      raise Game::BowlingError
    end

    if pins == 10
      @frames << [10, 0]
      @frames_allowance += BONUS_BALLS_AFTER_STRIKE if tenth_frame?
    elsif last_frame.nil? || (!last_frame[0].nil? && !last_frame[1].nil?)
      add_new_frame(pins)
    elsif last_frame[1].nil?
      first_throw = last_frame[0]
      combo = first_throw + pins
      raise Game::BowlingError if combo > 10

      @frames[@frames.size - 1][1] = pins

      @frames_allowance += BONUS_BALLS_AFTER_SPARE if combo == 10 && tenth_frame?
    else
      add_new_frame(pins)
    end
  end

  def score
    raise Game::BowlingError unless @frames.size.between?(10, @frames_allowance)
    raise Game::BowlingError if (strike?(@frames[9]) || spare?(@frames[9])) && @frames.size < 11
    raise Game::BowlingError if strike?(@frames[9]) && strike?(@frames[10]) && @frames.size < 12

    score = 0

    @frames.each.with_index do |frame, index|
      score += 10 + strike_bonus(index) if strike?(frame)
      score += 10 + spare_bonus(index) if spare?(frame)
      score += open_frame_score(frame) if open_frame?(frame)
    end

    score
  end

  private

  def frame_completed?(frame)
    frame[0] && frame[1]
  end

  def add_new_frame(pins)
    @frames << [pins, nil]
  end

  def bonus_roll?
    @frames.size.between?(10, 11)
  end

  def tenth_frame?
    @frames.size == 10
  end

  def strike_bonus(frame_index)
    frame_next = @frames[frame_index + 1]
    return 0 if frame_next.nil? || frame_index >= 9

    frame_following_next = @frames[frame_index + 2]

    sum = frame_next.sum
    sum += frame_following_next[0] if frame_following_next && strike?(frame_next)
    sum
  end

  def spare_bonus(frame_index)
    frame_next = @frames[frame_index + 1]
    return 0 if frame_next.nil? || frame_index >= 9

    frame_next[0]
  end

  def open_frame_score(frame)
    frame[0] + (frame[1] || 0)
  end

  def open_frame?(frame)
    frame && frame[0] + (frame[1] || 0) < 10
  end

  def strike?(frame)
    frame && frame[0] == 10
  end

  def spare?(frame)
    !strike?(frame) && frame[0] + (frame[1] || 0) == 10
  end
end
