module Luhn
  def self._valid?(string)
    string = string.gsub("\s", '') # string = string.delete()
    digits = string.scan(/\d/).map(&:to_i)
    return false if string.length < 2 || digits.size != string.size

    sum = digits.reverse.each_with_index.sum do |digit, index|
      next digit if index.even?

      doubled = digit * 2
      doubled < 10 ? doubled : doubled - 9
    end

    (sum % 10).zero?
  end

  # pure chaining
  # https://exercism.org/tracks/ruby/exercises/luhn/solutions/TerloevIslam
  def self.valid?(input)
    (input
      .gsub(/\s/, '')
      # \A asserts position at start of the string
      # \z asserts position at the end of the string
      # \d\d+ -> 1 digit + at least 1 digit more expected (so at least 2 to unlimited)
      .tap { |s| return false unless s[/\A\d\d+\z/] } #
      .chars
      .reverse
      .map.with_index { |d, i| i.odd? ? d.to_i * 2 : d.to_i }
      .map { |d| d > 9 ? d - 9 : d }
      .sum % 10).zero?
  end
end
