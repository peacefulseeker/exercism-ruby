class Cipher
  ALPHA = ('a'..'z').to_a
  SHIFT = 4
  ENCODE = :+
  DECODE = :-

  attr_reader :key

  def initialize(key = generate_key)
    raise ArgumentError unless key.match?(/\A[a-z]+\z/)

    @key = key
  end

  def generate_key
    # ALPHA[rand(0...26)] * 100 # generateing same chars
    # 100.times.map { ALPHA.sample(1) }.join
    ALPHA.sample(100).join
  end

  def encode(plaintext)
    shift(plaintext, ENCODE)
  end

  def decode(encoded)
    shift(encoded, DECODE)
  end

  def shift(text, operation)
    text.chars.map.with_index do |char, index|
      new_index = char_to_index(char).send(operation, char_to_index(@key[index])) % ALPHA.size
      ALPHA[new_index]
    end.join
  end

  # quite smart way to detect position in alphabet
  def char_to_index(char)
    char.ord - 'a'.ord
  end

  def index_to_char(index)
    ('a'.ord + (index % 26)).chr
  end
end
