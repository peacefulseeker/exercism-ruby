module Isogram
  class NotIsogramError < StandardError; end

  def self.isogram?(input)
    input.downcase.chars.each_with_object(Hash.new(0)) do |char, hash|
      raise NotIsogramError if hash[char].positive? && ![' ', '-'].include?(char)

      hash[char] += 1
    end

    true
  rescue NotIsogramError
    false
  end
end
