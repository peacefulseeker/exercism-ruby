class PigLatin
  VOWELS = %w[a e i o u].freeze
  RULE_1 = /[#{VOWELS}]|xr|yt/
  RULE_2 = /\A[^#{VOWELS}]+/
  RULE_3 = /\A[^#{VOWELS}]*qu/
  RULE_4 = /\A[^#{VOWELS}]+(?=y)/

  def self.translate(phrase)
    pl = PigLatin.new
    phrase.split.map { |word| pl.translate(word) }.join(' ')
  end

  def translate(word)
    return apply_rule_four(word) if word.start_with?(RULE_4)
    return apply_rule_three(word) if word.start_with?(RULE_3)
    return add_ay(word) if word.start_with?(RULE_1)

    apply_rule_two(word)
  end

  private

  def add_ay(word)
    "#{word}ay"
  end

  def apply_rule_two(word)
    consonants = word.gsub!(RULE_2).to_a.join
    add_ay("#{word}#{consonants}")
  end

  def apply_rule_three(word)
    consonants = word.gsub!(RULE_3).to_a.join
    add_ay("#{word}#{consonants}")
  end

  def apply_rule_four(word)
    consonants = word.gsub!(RULE_4).to_a.join
    add_ay("#{word}#{consonants}")
  end
end
