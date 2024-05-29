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
