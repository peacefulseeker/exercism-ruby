class Game
  class BowlingError < StandardError; end

  PINS = { MIN: 0, MAX: 10 }.freeze
  BONUS_BALLS_AFTER_SPARE = 1
  BONUS_BALLS_AFTER_STRIKE = 2

  def initialize
    @frames = []
    @frames_allowance = 10
  end

  def roll(pins)
    raise Game::BowlingError unless pins.between?(PINS[:MIN], PINS[:MAX])

    validate_pins_on_bonus_roll_frames(pins) if bonus_roll?

    last_frame = @frames[-1]
    if pins == PINS[:MAX]
      @frames.push(Frame.new(pins))
      @frames_allowance += BONUS_BALLS_AFTER_STRIKE if tenth_frame?
    elsif last_frame&.open?
      first_throw = last_frame.first
      potential_sum = first_throw + pins
      raise Game::BowlingError if potential_sum > PINS[:MAX]

      @frames_allowance += BONUS_BALLS_AFTER_SPARE if potential_sum == PINS[:MAX] && tenth_frame?
      last_frame.throw(pins)
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
      score += if frame.strike? || frame.spare?
                 strike_or_spare_bonus(index)
               elsif frame.open_frame?
                 open_frame_score(frame)
               else
                 frame.score
               end
    end
    score
  end

  private

  def validate_pins_on_bonus_roll_frames(pins)
    last_frame = @frames[-1]
    frame_before_last = @frames[-2]
    if cannot_roll_strike_after_bonus_roll_non_strike?(last_frame, frame_before_last, pins) ||
       cannot_roll_after_bonus_open_frame_roll?(last_frame) ||
       cannot_roll_after_bonus_roll_for_spare?(last_frame, frame_before_last)

      raise Game::BowlingError
    end
  end

  def cannot_roll_after_bonus_open_frame_roll?(last_frame)
    last_frame.completed? && last_frame.open_frame?
  end

  def cannot_roll_strike_after_bonus_roll_non_strike?(last_frame, frame_before_last, pins)
    frame_before_last.strike? && last_frame.first != PINS[:MAX] && pins == PINS[:MAX]
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

  # bonus rolls(after 10th frame) not suppoed to have extra points
  # regardless of strike/or spare frames previously
  def eligible_for_bonus?(index)
    index < 9
  end

  def strike_or_spare_bonus(index)
    return PINS[:MAX] unless eligible_for_bonus?(index)

    first_three_rolls = 3
    frames = [*@frames[index..index + 2]]
    frames.map(&:rolls).flatten.take(first_three_rolls).sum
  end

  def open_frame_score(frame)
    frame.first + frame.second.to_i
  end
end

class Frame
  def initialize(pins)
    @rolls = [pins]
  end

  attr_reader :rolls

  def throw(pins)
    @rolls << pins
  end

  def first
    @rolls.first
  end

  def second
    @rolls.last
  end

  def completed?
    strike? || (@rolls.size == 2)
  end

  def open?
    !completed?
  end

  def score
    @rolls.sum
  end

  def strike?
    first == Game::PINS[:MAX]
  end

  def spare?
    first + second.to_i == Game::PINS[:MAX]
  end

  def open_frame?
    first + second.to_i < Game::PINS[:MAX]
  end
end
