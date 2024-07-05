# https://github.com/exercism/ruby/blob/main/exercises/practice/bowling/.meta/example.rb
class Game
  PINS = { MIN: 0, MAX: 10 }.freeze
  at_exit { public :roll, :score }

  class BowlingError < StandardError; end
  class RollError < BowlingError; end
  class GameError < BowlingError; end

  private

  def initialize
    # it will have {} value, but good idea to demonstrate what it's going be filled in later on
    @score_card = Hash.new { |frame_number, k| frame_number[k] = [] }
    @score_card[1]
  end

  def roll(pins)
    validate(pins)
    @score_card[current_frame] << pins
    @score_card[current_frame + 1] unless last_frame? || !frame_complete?
  end

  def validate(pins)
    raise RollError, 'Invalid number of pins' unless (PINS[:MIN]..PINS[:MAX]).cover?(pins)
    raise RollError, 'Too many pins in frame' unless valid_frame?(pins)
    raise GameError, 'Game is over, no rolls allowed' if game_complete?
  end

  def valid_frame?(pins)
    last_roll_was_strike = @score_card[current_frame].last == 10

    # wonderufl, now I know how to treat nil to 0 => nil.to_i == 0
    (last_frame? && last_roll_was_strike || spare?) ||
      @score_card[current_frame].last.to_i + pins <= PINS[:MAX]
  end

  def score
    raise GameError, 'Score unavailable until end of the game' unless game_complete?

    @score_card.values.map.with_index(1) do |f, i|
      score_frame(f, i)
    end.reduce(:+)
  end

  def score_frame(f, i)
    strike_or_spare = [f.first, f.sum].any? { |e| e == PINS[:MAX] }

    if strike_or_spare
      special(@score_card[i], @score_card[i + 1], @score_card[i + 2])
    else
      f.sum
    end
  end

  # wow, super smart approach to take first 3 of flattened frames!
  def special(*frames)
    first_three_scores = 0..2
    frames.flatten[first_three_scores].sum
  end

  def current_frame
    @score_card.keys.max
  end

  def game_complete?
    last_frame? && frame_complete?
  end

  def last_frame?
    current_frame == 10
  end

  def frame_complete?
    if last_frame?
      frame_filled && open_frame? || frame_filled(3)
    else
      frame_filled || strike?
    end
  end

  def frame_filled(rolls = 2)
    @score_card[current_frame].size == rolls
  end

  def open_frame?
    !(strike? || spare?)
  end

  def strike?
    @score_card[current_frame].first == 10
  end

  def spare?
    @score_card[current_frame].sum == 10
  end
end
