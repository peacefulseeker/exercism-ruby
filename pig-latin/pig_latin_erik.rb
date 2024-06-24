# https://exercism.org/tracks/ruby/exercises/pig-latin/solutions/ErikSchierboom

module PigLatin
  VOWEL_REGEX = /(?<begin>^|\s+)(?<vowel>a|e|i|o|u|yt|xr)(?<rest>\w+)/
  CONSONANT_REGEX = /(?<begin>^|\s+)(?<consonant>ch|qu|thr|th|rh|sch|yt|\wqu|\w)(?<rest>\w+)/
  CONSONANT_REPLACEMENT = '\k<begin>\k<rest>\k<consonant>ay'.freeze

  def self.translate(sentence)
    if sentence.match?(VOWEL_REGEX)
      "#{sentence}ay"
    else
      sentence.gsub(CONSONANT_REGEX, CONSONANT_REPLACEMENT)
    end
  end
end
