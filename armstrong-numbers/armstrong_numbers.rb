module ArmstrongNumbers
  def self.include?(number)
    nums = number.to_s.chars
    nums.map { |num| num.to_i**nums.size }.sum == number
  end
end
