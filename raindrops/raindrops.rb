class Raindrops
  def self.convert(number)
    res = ''
    res += 'Pling' if (number % 3).zero?
    res += 'Plang' if (number % 5).zero?
    res += 'Plong' if (number % 7).zero?
    return res unless res.empty?

    number.to_s
  end
end
