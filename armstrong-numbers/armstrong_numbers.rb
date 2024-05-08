module ArmstrongNumbers
  def self.include?(number)
    number.digits.map { |n| n**number.digits.size }.sum == number
  end
end
