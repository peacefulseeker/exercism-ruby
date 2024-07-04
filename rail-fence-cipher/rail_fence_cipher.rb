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
        next_index_to_add = row
        row_char_indices = (row..text_length - 1).map.with_object([]) do |index, indices|
          next if index != next_index_to_add

          indices.push(index)
          next_index_to_add = if indices.size.even? && !indices.empty?
                                # downward direction search
                                # at this point we assume, that after adding 2,4,6 items,
                                # the zig zag finishes/finished its cycle and the next potential
                                # item will be found going downward.
                                next_index_to_add + row + row
                              else
                                # upward direction search
                                next_index_to_add + (max_index_gap - row * 2)
                              end
        end
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
