class Phrase
  def initialize(phrase)
    @phrase = phrase
  end

  def word_count
    return word_count_improved
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


  def word_count_improved
    # https://exercism.org/tracks/ruby/exercises/word-count/solutions/erikpivotal
    # match words with boundary
    words = @phrase.downcase.scan(/\b[\w']+\b/)
    # default value for hash is important, since math operations will follow
    words.each_with_object(Hash.new(0)) { |string, hash| hash[string] += 1 }

    # Returns a hash containing the counts of equal elements:
    # @phrase.downcase.scan(/\b[\w']+\b/).tally
  end
end
