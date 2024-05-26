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
