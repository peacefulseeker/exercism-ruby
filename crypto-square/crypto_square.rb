class Crypto
  def initialize(message)
    @message = message.downcase.gsub(/[^a-z0-9]/, '')
  end

  def ciphertext
    # get first number with square root value greater then or equal to message length
    row_length = 1
    row_length += 1 until row_length**2 >= @message.length

    @message
      .scan(/.{1,#{row_length}}/)
      .map { |row| format("%-#{row_length}s", row).chars }
      .transpose
      .map(&:join)
      .join(' ')
  end
end

# https://exercism.org/tracks/ruby/exercises/crypto-square/solutions/CROUZET
# looks quite elegant!

class CryptoCrouzet
  attr_reader :normalized_text, :size

  def initialize(plaintext)
    @normalized_text = plaintext.downcase.scan(/[[:alnum:]]/).join
    @size = Math.sqrt(normalized_text.length).ceil
  end

  def ciphertext
    return '' unless size.positive?

    normalized_text
      .chars
      .each_slice(size)
      .map { |slice| slice.join.ljust(size).chars }
      .transpose
      .map(&:join)
      .join(' ')
  end
end
