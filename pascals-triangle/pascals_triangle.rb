class Triangle
  def initialize(num_rows)
    @num_rows = num_rows
  end

  def rows
    @num_rows.times.with_object([]) do |row, result|
      next result << [1] if row.zero?

      prev_row = result[row - 1]
      result << Array.new(row + 1) do |i|
        prev_row_relative_left_value = (i - 1) >= 0 ? prev_row[i - 1] : 0
        prev_row_relative_right_value = prev_row[i] || 0
        prev_row_relative_left_value + prev_row_relative_right_value
      end
    end
  end
end
