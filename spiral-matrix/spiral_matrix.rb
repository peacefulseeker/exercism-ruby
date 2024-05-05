class SpiralMatrix
  DIRECTION_INCREMENTS = {
    right: [0, 1],
    bottom: [1, 0],
    left: [0, -1],
    top: [-1, 0]
  }.freeze

  DIRECTIONS_MAP = {
    right: :bottom,
    bottom: :left,
    left: :top,
    top: :right
  }.freeze

  def initialize(size)
    @size = size
  end

  def matrix
    return [] if @size.zero?
    return [[1]] if @size == 1

    render_matrix
  end

  private

  attr_reader :mtrx

  def render_matrix
    counter = 1
    direction = :right
    coords = [0, 0]
    @mtrx = Array.new(@size) { Array.new(@size, 0) }

    loop do
      el = mtrx[coords[0]][coords[1]]
      return mtrx unless el.zero?

      mtrx[coords[0]][coords[1]] = counter

      case direction
      when :right
        successor = mtrx[coords[0]][coords[1] + 1]
        direction = DIRECTIONS_MAP[direction] if successor.nil? || successor.positive?
      when :bottom
        bottom_row = mtrx[coords[0] + 1]
        direction = DIRECTIONS_MAP[direction] if bottom_row.nil? || bottom_row[coords[1]].positive?
      when :left
        successor = mtrx[coords[0]][coords[1] - 1]
        direction = DIRECTIONS_MAP[direction] if successor.nil? || successor.positive?
      when :top
        top_row = mtrx[coords[0] - 1]
        direction = DIRECTIONS_MAP[direction] if top_row.nil? || top_row[coords[0]].positive?
      end

      coords[0] += DIRECTION_INCREMENTS[direction][0]
      coords[1] += DIRECTION_INCREMENTS[direction][1]

      counter += 1
    end
  end
end
