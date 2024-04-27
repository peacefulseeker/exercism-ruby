class Phrase
  def initialize(phrase)
    @phrase = phrase
  end

  def word_count
    # split by any NON-alphanumeric characters leave out apostrophes
    # remove apostrophes from beginning and end of words
    # filter out empty strings
    words = @phrase.downcase.split(/[^a-zA-Z0-9']/)
      .map {|i| i.gsub(/^'|'$/, '')}
      .filter {|i| not i.empty?}

    counts = Hash.new(0)
    words.each do |word|
      counts[word] += 1
    end
    counts
  end
end
