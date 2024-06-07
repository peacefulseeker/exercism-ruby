class Cipher
  ALPHA = ('a'..'z').to_a
  SHIFT = 4

  attr_reader :key

  def initialize(key = generate_key)
    raise ArgumentError unless key.match?(/\A[a-z]+\z/)

    @key = key
  end

  def generate_key
    ALPHA[rand(0...26)] * 10
  end

  def encode(plaintext)
    transformed(plaintext, :+).join
  end

  def decode(encoded)
    transformed(encoded, :-).join
  end

  def transformed(text, operation)
    text.chars.map.with_index do |char, index|
      new_index = ALPHA.index(char).send(operation, ALPHA.index(key[index])) % ALPHA.size
      ALPHA[new_index]
    end
  end
end
