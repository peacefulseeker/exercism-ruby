class Pangram
  LETTERS = ('a'..'z').to_a

  def self.pangram?(sentence)
    LETTERS.all? { |letter| sentence.downcase.include?(letter) }
  end
end
