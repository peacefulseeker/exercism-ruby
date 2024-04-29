class Series
  attr_reader :string

  def initialize(string)
    @string = string
  end

  def slices(slices_num)
    raise ArgumentError if string.empty? || slices_num <= 0 || slices_num >= 6

    mapping = string.chars.map.with_index do |_, index|
      string[index..index + slices_num - 1]
    end
    mapping.filter { |i| i.size == slices_num }
  end
end
