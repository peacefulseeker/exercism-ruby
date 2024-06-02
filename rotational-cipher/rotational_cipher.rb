class RotationalCipher
  ALPHA = ('a'..'z').to_a

  def self.rotate(string, shift)
    new.rotate(string, shift)
  end

  def rotate(string, shift)
    string.chars.map { |char| char_to_cipher(char, shift) }.join
  end

  def char_to_cipher(char, shift)
    char_index = ALPHA.index(char.downcase)
    if char_index
      new_index = (shift + char_index) % ALPHA.size
      is_upcase = char == char.upcase
      is_upcase ? ALPHA[new_index].upcase : ALPHA[new_index]
    else
      char
    end
  end
end
