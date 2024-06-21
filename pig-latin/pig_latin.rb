class PigLatin
  VOWELS = %w[a e i o u].freeze
  CONSONANTS = ('a'..'z').to_a - VOWELS
  RULE_4 = /^(?<consonants>[#{CONSONANTS}]+)(?<named>y)/
  RULE_3 = /^[#{CONSONANTS}]*qu/
  RULE_1 = /[#{VOWELS}]|xr|yt/
  RULE_2 = /^[#{CONSONANTS}]+/

  def self.translate(phrase)
    pl = PigLatin.new
    phrase.split.map { |word| pl.translate(word) }.join(' ')
  end

  def translate(word)
    return apply_rule_four(word) if word.start_with?(RULE_4)
    return apply_rule_three(word) if word.start_with?(RULE_3)
    return apply_rule_one(word) if word.start_with?(RULE_1)

    apply_rule_two(word) if word.start_with?(RULE_2)
  end

  private

  def apply_rule_one(word)
    "#{word}ay"
  end

  def apply_rule_two(word)
    consonants = word.gsub!(RULE_2).to_a.join
    "#{word}#{consonants}ay"
  end

  def apply_rule_three(word)
    consonants = word.gsub!(RULE_3).to_a.join
    "#{word}#{consonants}ay"
  end

  def apply_rule_four(word)
    consonants, y = word.match(RULE_4).captures
    word = word.sub(consonants + y, '')
    "#{y}#{word}#{consonants}ay"
  end
end
