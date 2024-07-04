class RailFenceCipher
  def self.encode(*args)
    new.encode(*args)
  end

  def self.decode(*args)
    new.decode(*args)
  end

  def encode(text, rails)
    return text if identical_output?(rails, text)

    increment = 1
    row = 0
    field ||= field(rails, text)
    text.chars.each_with_index do |char, index|
      field[row][index] = char

      increment = -increment if index.positive? && (index % (rails - 1)).zero?
      row += increment
    end

    field.flatten.join
  end

  def decode(text, rails)
    return text if identical_output?(rails, text)

    field ||= field(rails, text)

    text_length = text.length

    max_index_gap = rails * 2 - 2
    rails.times do |row|
      first_row = row.zero?
      last_row = row == rails - 1
      if first_row || last_row
        row_char_indices = (row..text_length - 1).step(max_index_gap).to_a
      else
        index_gap = max_index_gap - row * 2
        row_char_indices = (row..text_length - 1).step(index_gap).to_a
      end
      row_chars = text.slice!(0, row_char_indices.length)
      row_chars.chars.zip(row_char_indices).each do |char, index|
        field[row][index] = char
      end
    end
    field.transpose.join
  end

  private

  def identical_output?(rails, text)
    rails == 1 || text.empty? || text.length == rails
  end

  def field(rails, text)
    Array.new(rails) { Array.new(text.length) }
  end
end
