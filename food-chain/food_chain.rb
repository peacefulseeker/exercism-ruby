require 'ostruct'
class Creature < OpenStruct; end

class FoodChain
  VERSE_I_KNOW = "I know an old lady who swallowed a %<creature>s.\n".freeze
  VERSE_SHE_SWALLOWED = "She swallowed the %<predator>s to catch the %<prey_description>s.\n".freeze

  CREATURES = [
    Creature.new(name: 'fly', intro: "I don't know why she swallowed the fly. Perhaps she'll die.\n"),
    Creature.new(name: 'spider', intro: "It wriggled and jiggled and tickled inside her.\n",
                 extra: ' that wriggled and jiggled and tickled inside her'),
    Creature.new(name: 'bird', intro: "How absurd to swallow a bird!\n"),
    Creature.new(name: 'cat', intro: "Imagine that, to swallow a cat!\n"),
    Creature.new(name: 'dog', intro: "What a hog, to swallow a dog!\n"),
    Creature.new(name: 'goat', intro: "Just opened her throat and swallowed a goat!\n"),
    Creature.new(name: 'cow', intro: "I don\'t know how she swallowed a cow!\n"),
    Creature.new(name: 'horse', intro: "She's dead, of course!\n")
  ].freeze

  def self.song
    new.song
  end

  def song
    CREATURES.map.with_index { |creature, index| verse(creature, index) }.join("\n")
  end

  def verse(creature, index)
    verse = format(VERSE_I_KNOW, creature: creature.name) + creature.intro
    verse += verses_up_to_animal(index) unless first_or_last_verse(creature.name)
    verse
  end

  def first_or_last_verse(name)
    CREATURES.first.name == name || CREATURES.last.name == name
  end

  def verses_up_to_animal(index)
    verses = CREATURES[..index].reverse.each_cons(2).map do |predator, prey|
      prey_description = [prey.name, prey.extra].compact.join
      format(VERSE_SHE_SWALLOWED, predator: predator.name, prey_description:)
    end

    verses << CREATURES.first.intro
    verses.join
  end
end
