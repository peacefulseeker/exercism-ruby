module Isogram
  class NotIsogramError < StandardError; end

  def self._isogram?(string)
    string.downcase.chars.each_with_object(Hash.new(0)) do |char, hash|
      raise NotIsogramError if hash[char].positive? && ![' ', '-'].include?(char)

      hash[char] += 1
    end

    true
  rescue NotIsogramError
    false
  end

  # https://exercism.org/tracks/ruby/exercises/isogram/solutions/4io
  # gathering all word characters in array form
  # comparing to the characters unique array
  def self.isogram?(string)
    chars = string.downcase.scan(/\w/)
    # chars = string.downcase.scan(/[a-z]/)
    chars.uniq == chars
  end
end
