class Acronym
  def self.abbreviate(phrase)
    # phrase.split(/[^a-zA-Z0-9']/).map { |word| word[0] }.join.upcase

    # https://exercism.org/tracks/ruby/exercises/acronym/solutions/dmunoz-10
    # phrase.split(/\W/).map(&:chr).join.upcase

    # https://exercism.org/tracks/ruby/exercises/acronym/solutions/dmunoz-10
    phrase.scan(/\b\w/).join.upcase
  end
end
