class Acronym
  def self.abbreviate(phrase)
    phrase.split(/[^a-zA-Z0-9']/).map { |word| word[0] }.join.upcase
  end
end
