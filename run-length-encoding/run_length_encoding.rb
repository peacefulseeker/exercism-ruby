class RunLengthEncoding
  def self.encode(string)
    chars = string.chars
    times = 0
    result = ''
    chars.each.with_index do |chr, index|
      times += 1
      next_differs = chars[index + 1] != chr
      if next_differs
        result << (times > 1 ? times.to_s + chr : chr)
        times = 0
      end
    end

    result
  end

  def self.decode(string)
    chars = string.chars
    result = ''
    times = ''
    chars.each do |chr|
      is_digit = chr =~ /\d/
      if is_digit
        times << chr
      else
        result << (times.empty? ? chr : chr * times.to_i)
        times = ''
      end
    end

    result
  end
end
