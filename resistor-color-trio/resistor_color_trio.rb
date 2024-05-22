class ResistorColorTrio
  COLORS = %w[black brown red orange yellow green blue violet grey white].freeze

  def initialize(colors_trio)
    @colors_trio = colors_trio
  end

  def first_two
    @colors_trio.take(2).map { |color| COLORS.index(color) }.join.to_i
  end

  def ohms
    third = COLORS.index(@colors_trio[-1])
    first_two * 10**third
  end

  def label
    kiloohms = ohms / 1000
    if kiloohms.nonzero?
      "Resistor value: #{kiloohms} kiloohms"
    else
      "Resistor value: #{ohms} ohms"
    end
  end
end
