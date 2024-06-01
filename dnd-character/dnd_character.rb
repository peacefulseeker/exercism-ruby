class DndCharacter
  BASE_HITPOINTS = 10
  ATTRIBUTES = %i[strength dexterity constitution intelligence wisdom charisma].freeze

  attr_reader(*ATTRIBUTES)

  def initialize
    ATTRIBUTES.each do |attribute|
      instance_variable_set("@#{attribute}", attribute_sum)
    end
  end

  def hitpoints
    BASE_HITPOINTS + self.class.modifier(constitution)
  end

  def self.modifier(score)
    ((score - BASE_HITPOINTS) / 2).round
  end

  private

  ROLLS = 1..6

  def roll
    rand(ROLLS)
  end

  def attribute_sum
    # 1..3 works as well, an extra test would not hurt to ensure 4 dices rolled?
    (1..4).map { roll }.sort { |a, b| b <=> a }.take(3).sum
  end
end
