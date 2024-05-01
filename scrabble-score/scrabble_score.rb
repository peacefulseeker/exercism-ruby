class Scrabble
  LETTER_SCORES = {
    # rubocop:disable Layout/HashAlignment
    %w[A E I O U L N R S T] => 1,
    %w[D G]                 => 2,
    %w[B C M P]             => 3,
    %w[F H V W Y]           => 4,
    %w[K]                   => 5,
    %w[J X]                 => 8,
    %w[Q Z]                 => 10
  }.freeze
  # rubocop:enable Layout/HashAlignment

  # for each letter in the string, generate a hash with a value
  # https://exercism.org/tracks/ruby/exercises/scrabble-score/solutions/Gao-Jun
  VALUES = {
    1 => %w[A E I O U L N R S T],
    2 => %w[D G],
    3 => %w[B C M P],
    4 => %w[F H V W Y],
    5 => %w[K],
    8 => %w[J X],
    10 => %w[Q Z]
  }.flat_map { |v, chars| chars.map { |char| [char, v] } }.to_h

  def initialize(string)
    @string = string
  end

  def score
    # @string.upcase.chars.sum do |char|
    #   char_key = LETTER_SCORES.keys.find { |k| k.include?(char) }
    #   VALUES[char_key]
    # end

    @string.upcase.chars.sum { |char| VALUES[char] }
  end
end
