class Garden
  CHILDREN = %w[alice bob charlie david eve fred ginny harriet ileana joseph kincaid larry].freeze
  LETTER_TO_PLANT = {
    'C' => :clover,
    'G' => :grass,
    'R' => :radishes,
    'V' => :violets
  }.freeze

  def initialize(garden)
    @plant_rows = garden.split "\n"
  end

  CHILDREN.each.with_index do |child, index|
    define_method child do
      child_plant_range = index * 2..index * 2 + 1
      @plant_rows.each.with_object([]) do |row, plants|
        plants.push(*row.chars[child_plant_range].map { |letter| LETTER_TO_PLANT[letter] })
      end
    end
  end
end
