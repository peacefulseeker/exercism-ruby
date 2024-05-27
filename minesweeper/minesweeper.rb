class Minesweeper
  MINE = '*'

  def self.annotate(input)
    new(input).annotate
  end

  attr_reader :field, :num_rows

  def initialize(input)
    @field = input.map(&:chars)
    @num_rows = @field.count
    # @num_cells = @field&.first&.count
  end

  def increment_cell(row_i, cell_i)
    cell = field[row_i][cell_i].to_i

    cell += 1 if cell_i - 1 >= 0 && field[row_i][cell_i - 1] == MINE
    cell += 1 if field[row_i][cell_i + 1] == MINE

    upper_row = row_i - 1
    if upper_row >= 0
      cell += 1 if field[upper_row][cell_i] == MINE
      cell += 1 if cell_i - 1 >= 0 && field[upper_row][cell_i - 1] == MINE
      cell += 1 if field[upper_row][cell_i + 1] == MINE
    end

    lower_row = row_i + 1
    if lower_row <= num_rows - 1
      cell += 1 if field[lower_row][cell_i] == MINE
      cell += 1 if cell_i - 1 >= 0 && field[lower_row][cell_i - 1] == MINE
      cell += 1 if field[lower_row][cell_i + 1] == MINE
    end

    return unless cell.positive?

    field[row_i][cell_i] = cell
  end

  def annotate
    field.each.with_index do |row, row_i|
      row.each.with_index do |cell, cell_i|
        increment_cell(row_i, cell_i) if cell != MINE
      end
    end

    field.map(&:join)
  end
end
