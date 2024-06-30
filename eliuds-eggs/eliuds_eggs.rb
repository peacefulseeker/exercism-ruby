class EliudsEggs
  def self.egg_count(num)
    # simple
    num.to_s(2).split('').map(&:to_i).sum

    # custom
    # binaries = from_decimal(num, 2).sum
  end

  def self.from_decimal(num, to_base)
    remainder = num
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
