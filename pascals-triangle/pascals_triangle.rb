class Triangle
  def initialize(num_rows)
    @num_rows = num_rows
  end

  def rows
    1.upto(@num_rows - 1).with_object([[1]]) do |row, result|
      prev_row = result.last
      result << Array.new(row + 1) do |i|
        prev_row_relative_left_value = (i - 1) >= 0 ? prev_row[i - 1] : 0
        prev_row_relative_right_value = prev_row[i] || 0
        prev_row_relative_left_value + prev_row_relative_right_value
      end
    end
  end
end

# https://exercism.org/tracks/ruby/exercises/pascals-triangle/solutions/ErikSchierboom
# quite smart when you know the formula!
class TriangleEric
  attr_reader :rows

  def initialize(row_count)
    @rows = 1.upto(row_count).map(&method(:row)).to_a
  end

  private

  def row(index)
    1.upto(index - 1).each_with_object([1]) do |j, elements|
      elements << elements.last * (index - j) / j
    end
  end
end

# https://exercism.org/tracks/ruby/exercises/pascals-triangle/solutions/gchan
# filling the middle first and ones on the edges later
class TriangleGchan
  def initialize(height)
    @height = height
  end

  def rows
    rows = [[1]]

    (@height - 1).times do
      row = []
      last_row = rows.last

      # fill the middle first
      (last_row.length - 1).times do |i|
        row << last_row[i] + last_row[i + 1]
      end

      # unshifht is same as prepend
      # essentially pushing ones(1) on the edges of array
      row.unshift(last_row.first)
      row << last_row.last

      rows << row
    end

    rows
  end
end
