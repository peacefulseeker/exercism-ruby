class IsbnVerifier
  def self.valid?(string)
    string.gsub!(/-/, '')
    digits = string.scan(/\d|X$/)
    return false if digits.size != 10 || string.length != digits.size

    results = digits.map.with_index do |d, i|
      d = d == 'X' ? 10 : d.to_i
      d * (10 - i)
    end

    (results.sum % 11).zero?
  end
end

# https://exercism.org/tracks/ruby/exercises/isbn-verifier/solutions/jchunky
# https://exercism.org/tracks/ruby/exercises/isbn-verifier/solutions/jesusMavahttps://exercism.org/tracks/ruby/exercises/isbn-verifier/solutions/jesusMava
class IsbnVerifierReduce
  VALID_ISBN_FORMAT = /^\d{9}[\dX]$/

  def self.valid?(string)
    string = string.delete('-')
    return false unless string[VALID_ISBN_FORMAT]

    sum = string
          .chars
          .map { |c| c == 'X' ? 10 : c.to_i }
          .map.with_index { |n, i| n * (10 - i) }
          .reduce(&:+)

    sum % 11 == 0
  end
end
