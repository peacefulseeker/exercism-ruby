class Brackets
  BRACKET_TO_BRACKET = { '(' => ')', '[' => ']', '{' => '}' }.freeze

  def self.paired?(string)
    chars = string.scan(/[\[\](){}]/)
    skip_possible_matches = Set.new
    chars.each.with_index do |char, index|
      next if skip_possible_matches.include?(index)

      expected_bracket = BRACKET_TO_BRACKET[char]
      matched_brackets = (index + 1...chars.length).step(2).find_all { |i| chars[i] == expected_bracket }
      return false if matched_brackets.empty?

      skip_possible_matches += matched_brackets
    end
  end
end

# https://exercism.org/tracks/ruby/exercises/matching-brackets/solutions/jhass
module BracketsJhass
  MAP = { '(' => ')', '[' => ']', '{' => '}' }.freeze
  CLOSING = MAP.values.freeze

  def self.paired?(input)
    stack = []

    input.each_char do |char|
      # assigment AND comparison at the same time
      if (pair = MAP[char])
        # expected pair will be pushed to the stack only for OPENING bracket case.
        stack << pair
      # closing bracket expected to be last in the stack, in case it has a pair
      elsif char == stack.last
        stack.pop
      # otherwise it's an unexpected closing bracket
      elsif CLOSING.include?(char)
        return false
      end
    end

    stack.empty?
  end
end

# https://exercism.org/tracks/ruby/exercises/matching-brackets/solutions/gitkeeper
class BracketsGitKeeper
  BRACKETS = { '(' => ')', '{' => '}', '[' => ']' }.freeze

  def self.paired?(string)
    stack = []

    string.each_char do |char|
      stack << char if BRACKETS.key?(char)
      return false if BRACKETS.key(char) && BRACKETS.key(char) != stack.pop
    end

    stack.empty?
  end
end
