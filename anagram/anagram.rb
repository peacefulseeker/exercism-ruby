class Anagram
  def initialize(word)
    @word = word.downcase
  end

  def match(phrases)
    phrases.select do |phrase|
      phrase.downcase != @word &&
        phrase.downcase.chars.sort == @word.chars.sort
    end
  end
end
