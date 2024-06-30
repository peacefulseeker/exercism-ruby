# with guidance in https://germanna.edu/sites/default/files/2022-03/Change%20of%20Number%20Bases.pdf
class BaseConverter
  def self.convert(*args)
    BaseConverter.new.convert(*args)
  end

  def convert(input_base, digits, output_base)
    raise ArgumentError if input_base < 2 || output_base < 2 || digits.any?(&:negative?)
    raise ArgumentError if digits.any? { |d| d >= input_base }
    return [0] unless digits.any?(&:positive?)

    from_decimal(to_decimal(input_base, digits), output_base)
  end

  def to_decimal(from_base, digits)
    # https://exercism.org/tracks/ruby/exercises/all-your-base/solutions/ajoshguy
    # [digits.reverse.map.with_index { |digit, i| digit * (from_base**i) }.sum]
    [digits.map.with_index { |d, index| d * from_base**(digits.length - index - 1) }.inject(0, :+)]
  end

  def from_decimal(digits, to_base)
    remainder = digits.join.to_i
    power = 0
    powers = []
    while to_base**power <= remainder
      powers.push(to_base**power)
      power += 1
    end
    powers.reverse.each.with_object([]) do |pow, numbers|
      number, remainder = remainder.divmod(pow)
      numbers.push(number)
    end
  end
end
