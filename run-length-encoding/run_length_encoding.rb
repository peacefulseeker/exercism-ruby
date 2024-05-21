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

# https://exercism.org/tracks/ruby/exercises/run-length-encoding/solutions/mjording
# smart thing here is that single chars / without digits will be left untouched
# encoding -> grouping by previously matched char
# decoding -> grouping by digits + unlmited chars after that, and before next digit
class RunLengthEncodingRegexp
  def self.encode(input)
    input.gsub(/(.)\1+/) { |m| "#{m.length}#{m[0]}" }
  end

  def self.decode(input)
    input.gsub(/\d+./) { |m| m[-1] * m.to_i }
  end
end

# https://exercism.org/tracks/ruby/exercises/run-length-encoding/solutions/jhass
# Array#chunk_while is quite convenient is such scenario
# well done jhass! that's not the first solution I liked  form this huy
module RunLengthEncodingChunk
  def self.encode(input)
    input
      .each_char
      .chunk_while { |a, b| a == b }
      .map { |letters| letters.size == 1 ? letters.first : "#{letters.size}#{letters.first}" }
      .join
  end

  # 2 groups for each of scans
  # \d* matches any digit between zero and unlimited times
  # \D matches any non-digit(single non-digit expected in group)
  def self.decode(input)
    input
      .scan(/(\d*)(\D)/)
      .map { |count, letter| letter * (count.empty? ? 1 : count.to_i) }
      .join
  end
end
