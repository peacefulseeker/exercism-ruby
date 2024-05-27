# https://exercism.org/tracks/ruby/exercises/minesweeper/solutions/ukdave
# checking against current cell with 8 possible directions
class Minesweeper
  DIRECTIONS = [[-1, -1], [-1, 0], [-1, 1], [0, -1], [0, 1], [1, -1], [1, 0], [1, 1]].freeze

  def initialize(input)
    @grid = input.map(&:chars)
  end

  def self.annotate(input)
    new(input).annotate
  end

  def annotate
    @grid.map.with_index do |row, row_idx|
      row.map.with_index do |cell, cell_idx|
        cell_value(cell, row_idx, cell_idx)
      end.join
    end
  end

  private

  def cell_value(cell, row_idx, cell_idx)
    return cell if cell == '*'

    count = DIRECTIONS.sum do |row_offset, cell_offset|
      mine?(row_idx + row_offset, cell_idx + cell_offset) ? 1 : 0
    end

    count.positive? ? count : ' '
  end

  def mine?(row_idx, cell_idx)
    return false if row_idx < 0 || row_idx > @grid.length - 1
    # can safely check for grid.first.length here, because of previous conditions passed
    return false if cell_idx < 0 || cell_idx > @grid.first.length - 1

    @grid[row_idx][cell_idx] == '*'
  end
end
