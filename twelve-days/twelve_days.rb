class TwelveDays
  VERSE = 'On the %<day>s day of Christmas my true love gave to me: %<gifts>s.'.freeze
  DAYS = %w[first second third fourth fifth sixth seventh eighth ninth tenth eleventh twelfth].freeze
  GIFTS = [
    'a Partridge in a Pear Tree',
    'two Turtle Doves',
    'three French Hens',
    'four Calling Birds',
    'five Gold Rings',
    'six Geese-a-Laying',
    'seven Swans-a-Swimming',
    'eight Maids-a-Milking',
    'nine Ladies Dancing',
    'ten Lords-a-Leaping',
    'eleven Pipers Piping',
    'twelve Drummers Drumming'
  ].freeze

  def self.song
    song = DAYS.map.with_index do |day, index|
      gifts = GIFTS[0..index].reverse
      gifts[-1] = "and #{gifts[-1]}" if index.positive?
      gifts = gifts.join(', ')
      format(VERSE, day:, gifts:)
    end

    "#{song.join("\n\n")}\n"
  end
end

# beautiful 👏
# https://exercism.org/tracks/ruby/exercises/twelve-days/solutions/shioimm
class TwelveDays__
  GIFTS = [
    { first:    'a Partridge in a Pear Tree' },
    { second:   'two Turtle Doves' },
    { third:    'three French Hens' },
    { fourth:   'four Calling Birds' },
    { fifth:    'five Gold Rings' },
    { sixth:    'six Geese-a-Laying' },
    { seventh:  'seven Swans-a-Swimming' },
    { eighth:   'eight Maids-a-Milking' },
    { ninth:    'nine Ladies Dancing' },
    { tenth:    'ten Lords-a-Leaping' },
    { eleventh: 'eleven Pipers Piping' },
    { twelfth:  'twelve Drummers Drumming' }
  ].freeze

  def self.song
    # TODO: how's that called? I assume the purpose of method
    # to avoid creating singleton methods every time
    new.song
  end

  def song
    GIFTS.size.times.map { |index| verse(index) }.join("\n")
  end

  private

  def verse(index)
    "On the #{day(index)} day of Christmas my true love gave to me: #{to_phrase(gifts(index))}.\n"
  end

  def day(index)
    GIFTS[index].keys.first.to_s
  end

  def gifts(index)
    GIFTS.take(index + 1).flat_map(&:values).reverse
  end

  def to_phrase(gifts)
    *gifts, last_gift = gifts
    # first gift only on first row
    return last_gift if gifts.empty?

    "#{gifts.join(', ')}, and #{last_gift}"
  end
end
