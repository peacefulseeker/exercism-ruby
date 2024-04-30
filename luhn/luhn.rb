module Luhn
  def self.valid?(string)
    return false if string.scan(/[^0-9\s]/).any?

    digits = string.scan(/\d/).map(&:to_i)
    return false if digits.length < 2

    doubled = digits.reverse.map.with_index do |digit, index|
      next if index.even?

      doubled = digit * 2
      doubled < 10 ? doubled : doubled - 9
    end

    (doubled.reverse.sum % 10).zero?
  end
end
