class Minesweeper
  MINE = '*'

  def self.annotate(input)
    new(input).annotate
  end

  attr_reader :field

  def initialize(input)
    @field = input.map { |i| i.split('').map { |i_| i_ == MINE ? i_ : 0 } }
  end

  def annotate
    field.map.with_index do |row, row_i|
      row.map.with_index do |cell, cell_i|
        next cell if cell == MINE

        cell += 1 if cell_i - 1 >= 0 && row[cell_i - 1] == MINE
        cell += 1 if row[cell_i + 1] == MINE

        upper_row = row_i - 1
        if upper_row >= 0
          cell += 1 if cell_i - 1 >= 0 && field[upper_row][cell_i - 1] == MINE
          cell += 1 if field[upper_row][cell_i] == MINE
          cell += 1 if field[upper_row][cell_i + 1] == MINE
        end
        lower_row = row_i + 1
        if lower_row <= field.length - 1
          cell += 1 if cell_i - 1 >= 0 && field[lower_row][cell_i - 1] == MINE
          cell += 1 if field[lower_row][cell_i] == MINE
          cell += 1 if field[lower_row][cell_i + 1] == MINE
        end

        cell.zero? ? ' ' : cell
      end.join
    end
  end
end
