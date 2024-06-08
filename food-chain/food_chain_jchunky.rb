require 'ostruct'

# https://exercism.org/tracks/ruby/exercises/food-chain/solutions/jchunky
# this guys really rocks! Did almost 20 iterations :D
module FoodChain
  # convenient way to make instance methods into class methods
  extend self

  CRITTERS = [
    OpenStruct.new(name: 'fly', introduction: "I don't know why she swallowed the fly. Perhaps she'll die.",
                   detail: ".\nI don't know why she swallowed the fly. Perhaps she'll die"),
    OpenStruct.new(name: 'spider', introduction: 'It wriggled and jiggled and tickled inside her.',
                   detail: ' that wriggled and jiggled and tickled inside her'),
    OpenStruct.new(name: 'bird', introduction: 'How absurd to swallow a bird!'),
    OpenStruct.new(name: 'cat', introduction: 'Imagine that, to swallow a cat!'),
    OpenStruct.new(name: 'dog', introduction: 'What a hog, to swallow a dog!'),
    OpenStruct.new(name: 'goat', introduction: 'Just opened her throat and swallowed a goat!'),
    OpenStruct.new(name: 'cow', introduction: "I don't know how she swallowed a cow!"),
    OpenStruct.new(name: 'horse', introduction: "She's dead, of course!")
  ]

  def song
    CRITTERS.count.times.map(&method(:verse)).join("\n\n").concat("\n")
  end

  private

  def verse(i)
    first = critters(i).first
    [
      "I know an old lady who swallowed a #{first.name}.",
      first.introduction,
      chain(i)
    ].flatten.join("\n")
  end

  def chain(i)
    return [] if i == CRITTERS.count - 1

    critters(i).each_cons(2).map do |predator, prey|
      prey_description = [prey.name, prey.detail].compact.join
      "She swallowed the #{predator.name} to catch the #{prey_description}."
    end
  end

  def critters(i)
    CRITTERS.first(i + 1).reverse
  end
end
