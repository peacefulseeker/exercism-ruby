class Scrabble
  LETTER_SCORES = {
    %w[A E I O U L N R S T] => 1,
    %w[D G] => 2,
    %w[B C M P] => 3,
    %w[F H V W Y] => 4,
    %w[K] => 5,
    %w[J X] => 8,
    %w[Q Z] => 10
  }.freeze

  def initialize(string)
    @string = string
  end

  def score
    @string.upcase.chars.sum do |char|
      char_key = LETTER_SCORES.keys.find { |k| k.include?(char) }
      LETTER_SCORES[char_key]
    end
  end
end
