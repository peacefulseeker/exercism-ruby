class FoodChain
  VERSE_I_KNOW = "I know an old lady who swallowed a %<animal>s.\n".freeze
  VERSE_SHE_SWALLOWED = "She swallowed the %<animal1>s to catch the %<animal2>s.\n".freeze
  VERSE_SHE_SWALLOWED_THE_BIRD =
    "She swallowed the bird to catch the spider that wriggled and jiggled and tickled inside her.\n".freeze

  ANIMAL_PHRASES = {
    fly: "I don't know why she swallowed the fly. Perhaps she'll die.\n",
    spider: "It wriggled and jiggled and tickled inside her.\n",
    bird: "How absurd to swallow a bird!\n",
    cat: "Imagine that, to swallow a cat!\n",
    dog: "What a hog, to swallow a dog!\n",
    goat: "Just opened her throat and swallowed a goat!\n",
    cow: "I don\'t know how she swallowed a cow!\n",
    horse: "She's dead, of course!\n"
  }.freeze

  def self.song
    new.song
  end

  def song
    ANIMAL_PHRASES.map.with_index { |(animal, phrase), index| verse(animal, phrase, index) }.join("\n")
  end

  def verse(animal, phrase, index)
    verse = format(VERSE_I_KNOW, animal:) + phrase
    verse += verses_up_to_animal(index) unless %i[fly horse].include?(animal)
    verse
  end

  def verses_up_to_animal(index)
    verses = ANIMAL_PHRASES.keys[..index].reverse.each_cons(2).map do |animal1, animal2|
      if animal1 == :bird
        VERSE_SHE_SWALLOWED_THE_BIRD
      else
        format(VERSE_SHE_SWALLOWED, animal1:, animal2:)
      end
    end

    verses.join + ANIMAL_PHRASES[:fly]
  end
end
