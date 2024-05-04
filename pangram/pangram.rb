class Pangram
  LETTERS = ('a'..'z').to_a

  def self.pangram?(sentence)
    # LETTERS.all? { |letter| sentence.downcase.include?(letter) }

    # https://exercism.org/tracks/ruby/exercises/pangram/solutions/frostyblok
    sentence.downcase.scan(/[a-z]/).uniq.length == LETTERS.size
  end
end
