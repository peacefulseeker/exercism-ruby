class Transpose
  def self.transpose(input)
    return '' if input.empty?

    res = []
    rows = input.split("\n")

    cols = rows.max_by(&:length).length
    cols.times do |index|
      # get the transposed chars from each row
      transposed = rows.map do |row|
        row[index]
      end

      # get rid of "last" nil values in array
      transposed = transposed.select.with_index do |item, item_index|
        item or '' unless item.nil? && transposed[item_index + 1..].all?(&:nil?)
      end

      # add spaces for "nil" items between normal chars
      transposed = transposed.map { |item| item.nil? ? ' ' : item }.join

      res.push(transposed)
    end

    res.join("\n")
  end
end

# quite elegant
# https://exercism.org/tracks/ruby/exercises/transpose/solutions/TarrinRos
class Transpose2
  def self.transpose(input)
    result = []
    # each row
    input.each_line.with_index do |line, index|
      line.strip.each_char.with_index do |char, i|
        # that type of formatting is composing a string with padding
        # depending on the index
        # format("%-0s", 's') => 's'
        # format("%-1s", 's') => 's'
        # format("%-2s", 's') => 's '
        # format("%-3s", 's') => 's  '
        # format("%-3s", nil) => '   '
        result[i] = format("%-#{index}s", result[i])
        result[i] += char
      end
    end
    result.join("\n")
  end
end

# TODO: unfinished really. Need to crack head a bit more
# essentially the same "`nil` between elements and in the end problem"
# based on https://exercism.org/tracks/ruby/exercises/transpose/solutions/Eggman
class Transpose3
  def self.transpose(input)
    # return '' if input.empty?

    chars = input.lines
                 .map(&:strip)
                 .map(&:chars)
    max_length = chars.max.length
    unless chars.all? { |item| item.size == max_length }
      chars = chars.map { |item| item.size < max_length ? item + Array.new(max_length - item.size).fill(' ') : item }
    end

    chars.transpose
         .map(&:join)
         .join("\n")
         .rstrip
  end
end
