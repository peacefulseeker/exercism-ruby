class Crypto
  def initialize(message)
    @message = message.downcase.gsub(/[^a-z0-9]/, '')
  end

  def ciphertext
    # get first number with square root value greater then or equal to message length
    row_length = 1
    row_length += 1 until row_length**2 >= @message.length

    # get text chunks of row_length
    result = []
    crypted = @message
              .scan(/.{1,#{row_length}}/)
              .map { |row| format("%-#{row_length}s", row) }

    # transpose each row chunks
    crypted.each do |row|
      row.each_char.with_index do |char, i|
        result[i] = format('%s', result[i]) # first need to handle nil case and format as ''
        result[i] += char
      end
    end

    result.join(' ')
  end
end
