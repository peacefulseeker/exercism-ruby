class Game
  class BowlingError < StandardError; end

  BONUS_BALLS_AFTER_SPARE = 1
  BONUS_BALLS_AFTER_STRIKE = 2
  STRIKE_SCORE = 10

  def initialize
    @frames = []
    @frames_allowance = 10
  end

  def roll(pins)
    last_frame = @frames[-1]
    raise Game::BowlingError unless pins.between?(0, STRIKE_SCORE)
    raise Game::BowlingError if @frames.size >= @frames_allowance && last_frame.completed?

    if bonus_roll?
      frame_before_last = @frames[-2]
      if cannot_roll_strike_after_bonus_roll_non_strike?(last_frame, frame_before_last, pins) ||
         cannot_roll_after_bonus_open_frame_roll?(last_frame) ||
         cannot_roll_after_bonus_roll_for_spare?(last_frame, frame_before_last)

        raise Game::BowlingError
      end
    end

    if pins == STRIKE_SCORE
      @frames.push(Frame.new(pins))
      @frames_allowance += BONUS_BALLS_AFTER_STRIKE if tenth_frame?
    elsif last_frame && !last_frame.completed?
      first_throw = last_frame.first
      potential_sum = first_throw + pins
      raise Game::BowlingError if potential_sum > STRIKE_SCORE

      @frames_allowance += BONUS_BALLS_AFTER_SPARE if potential_sum == STRIKE_SCORE && tenth_frame?
      last_frame.add(pins)
    else
      add_frame(pins)
    end
  end

  def score
    raise Game::BowlingError unless @frames.size.between?(10, @frames_allowance)
    raise Game::BowlingError if (@frames[9].strike? || @frames[9].spare?) && @frames.size < 11
    raise Game::BowlingError if @frames[9].strike? && @frames[10].strike? && @frames.size < 12

    score = 0

    @frames.each.with_index do |frame, index|
      score += 10 + strike_bonus(index) if frame.strike?
      score += 10 + spare_bonus(index) if frame.spare?
      score += open_frame_score(frame) if frame.open_frame?
    end

    score
  end

  private

  def cannot_roll_after_bonus_open_frame_roll?(last_frame)
    last_frame.completed? && last_frame.open_frame?
  end

  def cannot_roll_strike_after_bonus_roll_non_strike?(last_frame, frame_before_last, pins)
    frame_before_last.strike? && last_frame.first != STRIKE_SCORE && pins == STRIKE_SCORE
  end

  def cannot_roll_after_bonus_roll_for_spare?(last_frame, frame_before_last)
    !last_frame.completed? && frame_before_last.spare?
  end

  def add_frame(pins)
    @frames.push(Frame.new(pins))
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

    frame_after_next = @frames[frame_index + 2]

    [
      frame_next.sum,
      (frame_after_next && frame_next.strike? ? frame_after_next.first : 0),
    ].sum
  end

  def spare_bonus(frame_index)
    frame_next = @frames[frame_index + 1]
    return 0 if frame_next.nil? || frame_index >= 9

    frame_next.first
  end

  def open_frame_score(frame)
    frame.first + (frame.second || 0)
  end
end

class Frame
  def initialize(pins)
    @throws = [pins, pins == Game::STRIKE_SCORE ? 0 : nil]
  end

  def add(pins)
    @throws[1] = pins
  end

  def first
    @throws.first
  end

  def second
    @throws.last
  end

  def completed?
    @throws.none?(&:nil?)
  end

  def sum
    @throws.sum
  end

  def strike?
    first == Game::STRIKE_SCORE
  end

  def spare?
    !strike? && first + (second || 0) == Game::STRIKE_SCORE
  end

  def open_frame?
    first + (second || 0) < Game::STRIKE_SCORE
  end
end
