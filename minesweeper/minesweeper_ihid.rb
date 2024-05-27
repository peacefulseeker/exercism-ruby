# https://exercism.org/tracks/ruby/exercises/minesweeper/solutions/iHiD
# checking form MINE stand point
class Minesweeper
  def self.annotate(*args) = new(*args).annotate

  def initialize(input)
    @rows = input.map(&:chars)
    @num_rows = @rows.length
    @num_cells = @rows[0]&.length.to_i
  end

  def annotate
    rows.each.with_index do |row, row_idx|
      row.each.with_index do |cell, cell_idx|
        increment_cells(row_idx, cell_idx) if cell == '*'
      end
    end
    rows.map(&:join)
  end

  private

  attr_reader :rows, :num_rows, :num_cells

  def increment_cells(row_idx, cell_id)
    [-1, 0, 1].each do |row_offset|
      [-1, 0, 1].each do |cell_offset|
        increment_cell(row_idx + row_offset, cell_id + cell_offset)
      end
    end
  end

  def increment_cell(row_idx, cell_idx)
    return if row_idx < 0 || row_idx > @num_rows - 1
    return if cell_idx < 0 || cell_idx > @num_cells - 1

    value = rows[row_idx][cell_idx]
    return if value == '*'

    rows[row_idx][cell_idx] = value.to_i + 1
  end
end
