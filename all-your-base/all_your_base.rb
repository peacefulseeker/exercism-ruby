# with guidance in https://germanna.edu/sites/default/files/2022-03/Change%20of%20Number%20Bases.pdf
class BaseConverter
  def self.convert(input_base, digits, output_base)
    new.convert(input_base, digits, output_base)
  end

  def convert(input_base, digits, output_base)
    raise ArgumentError if input_base < 2 || output_base < 2 || digits.any?(&:negative?)
    raise ArgumentError if digits.any? { |d| d >= input_base }

    if input_base == 10
      from_base_ten(digits, output_base)
    elsif output_base == 10
      to_base_ten(input_base, digits)
    else
      from_base_ten(to_base_ten(input_base, digits), output_base)
    end
  end

  def to_base_ten(input_base, digits)
    converted = digits.map.with_index { |d, index| d * input_base**(digits.length - index - 1) }.inject(0, :+)
    converted.to_s.split('').map(&:to_i)
  end

  def from_base_ten(digits, output_base)
    reminder = digits.join.to_i
    power = 0
    powers = []
    numbers = []
    while output_base**power <= reminder
      powers.push(output_base**power)
      power += 1
    end
    return [0] if powers.empty?

    powers.reverse.each do |p|
      numbers.push(reminder / p)
      reminder %= p
    end
    numbers
  end
end
