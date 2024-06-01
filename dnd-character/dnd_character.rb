class DndCharacter
  BASE_HITPOINTS = 10
  ATTRIBUTES = %i[strength dexterity constitution intelligence wisdom charisma].freeze

  ATTRIBUTES.each do |attribute|
    define_method attribute do
      instance_variable_get("@#{attribute}") || instance_variable_set("@#{attribute}", attribute_sum)
    end
  end
  def roll
    rand(1..6)
  end

  def attribute_sum
    # 1..3 works as well, an extra test would not hurt to ensure 4 dices rolled?
    (1..4).map { roll }.sort { |a, b| b <=> a }.take(3).sum
  end

  def hitpoints
    BASE_HITPOINTS + DndCharacter.modifier(constitution)
  end

  def self.modifier(score)
    ((score - BASE_HITPOINTS) / 2).round
  end
end
