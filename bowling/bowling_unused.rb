# https://exercism.org/tracks/ruby/exercises/bowling/solutions/unused

# Game provides Bowling score calculation, as well as the current frame number.
class Game
  # BowlingError determines a bad given score for a roll, negative left pins
  # for a frame, game has not been finished, or too many rolls for a frame.
  class BowlingError < StandardError; end

  class Frame
    attr_reader :throws
    # good idea to track the next frame
    attr_accessor :next_frame

    def initialize(number)
      @number = number
      @throws = []
    end

    def throw(pins)
      raise BowlingError if !open? || (left_pins - pins).negative?

      @throws << pins
    end

    def final?
      @number == 10
    end

    def bonus?
      @number > 10
    end

    def closed?
      strike? || @throws.count == 2
    end

    def open?
      !closed?
    end

    def left_pins
      10 - @throws.sum
    end

    def strike?
      @throws&.first == 10
    end

    def spare?
      !strike? && left_pins.zero?
    end

    def score
      return spare_score if spare? && !bonus?
      return strike_score if strike? && !bonus?

      10 - left_pins
    end

    private

    def spare_score
      return 10 if final?

      10 + next_frame.throws.first
    end

    def strike_score
      return 10 if final?
      return 20 + next_frame.next_frame.throws.first if next_frame.strike?

      10 + next_frame.score
    end
  end

  def initialize
    @frames = []
  end

  def roll(pins)
    raise BowlingError if !(0..10).cover?(pins) || finished?

    if @frames.last&.open?
      @frames.last.throw pins
    else
      frame = Frame.new(current_frame_number + 1)
      frame.throw pins
      @frames.last&.next_frame = frame
      @frames << frame
    end
  end

  def current_frame_number
    @frames.count
  end

  def finished?
    return @frames[10]&.throws&.count == 1 if final_frame&.spare?

    if final_frame&.strike?
      return @frames[11]&.throws&.count == 1 if @frames[10]&.strike?

      @frames[10]&.closed?
    else
      @frames[9]&.throws&.count == 2
    end
  end

  def final_frame
    @final_frame ||= @frames.find(&:final?)
  end

  def score
    raise BowlingError unless finished?

    @frames.map(&:score).sum
  end
end
