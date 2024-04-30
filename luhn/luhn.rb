module Luhn
  def self.valid?(string)
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
end
