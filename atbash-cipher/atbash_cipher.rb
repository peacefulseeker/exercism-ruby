class Atbash
  ALPHA = ('a'..'z').to_a
  CIPHER = ALPHA.reverse

  def self.encode(plaintext)
    encoded = plaintext.downcase.scan(/[a-z0-9]/).join.gsub(/[a-z]/) { |c| ALPHA[CIPHER.index(c)] }
    slices = encoded.chars.each_slice(5).map(&:join)
    slices.join(' ')
  end

  def self.decode(ciphertext)
    ciphertext.downcase.scan(/[a-z0-9]/).join.gsub(/[a-z]/) { |c| CIPHER[ALPHA.index(c)] }
  end
end
