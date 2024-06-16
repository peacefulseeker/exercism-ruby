class Affine
  ALPHA = ('a'..'z').to_a

  def initialize(key1, key2)
    @a = key1
    @b = key2
    @m = ALPHA.size

    raise ArgumentError, 'a and m must be coprime' unless @a.gcd(@m) == 1

    @mode_inverse ||= mod_inverse
  end

  attr_reader :mode_inverse

  def encode(plaintext)
    normalized(plaintext)
      .chars
      .map(&method(:encode_char))
      .join
      .scan(/.{1,5}/)
      .join(' ')
  end

  def decode(ciphertext)
    normalized(ciphertext)
      .chars
      .map(&method(:decode_char))
      .join
  end

  private

  def normalized(text)
    text.gsub(/\W/, '').downcase
  end

  def encode_char(char)
    return char if char =~ /\d/

    i = ALPHA.index(char)
    new_index = (@a * i + @b) % @m
    ALPHA[new_index]
  end

  def decode_char(char)
    return char if char =~ /\d/

    y = ALPHA.index(char)
    new_index = mode_inverse * (y - @b) % @m
    ALPHA[new_index]
  end

  def mod_inverse
    x = 1
    x += 1 until (x * @a) % @m == 1
    x
  end
end
