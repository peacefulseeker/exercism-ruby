require 'ostruct'

class Character < OpenStruct; end

class House
  CHARACTERS = [
    Character.new(name: 'house that Jack built.'),
    Character.new(name: 'malt', action: 'lay in'),
    Character.new(name: 'rat', action: 'ate'),
    Character.new(name: 'cat', action: 'killed'),
    Character.new(name: 'dog', action: 'worried'),
    Character.new(name: 'cow with the crumpled horn', action: 'tossed'),
    Character.new(name: 'maiden all forlorn', action: 'milked'),
    Character.new(name: 'man all tattered and torn', action: 'kissed'),
    Character.new(name: 'priest all shaven and shorn', action: 'married'),
    Character.new(name: 'rooster that crowed in the morn', action: 'woke'),
    Character.new(name: 'farmer sowing his corn', action: 'kept'),
    Character.new(name: 'horse and the hound and the horn', action: 'belonged to'),
  ].freeze

  def self.recite
    [].tap do |verses|
      CHARACTERS.each.with_index do |character, index|
        verse = "This is the #{character.name}\n"
        if index.positive?
          CHARACTERS[..index].reverse.each_cons(2) do |first, second|
            verse << "that #{first.action} the #{second.name}\n"
          end
        end
        verses << verse
      end
    end.join("\n")
  end
end
