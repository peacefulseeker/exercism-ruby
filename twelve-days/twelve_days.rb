class TwelveDays
  INTRO = 'On the %s day of Christmas my true love gave to me: %s.'.freeze
  DAYS = %w[first second third fourth fifth sixth seventh eighth ninth tenth eleventh twelfth].freeze
  PARTIALS = [
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
      partials = PARTIALS[0..index].reverse
      partials[-1] = "and #{partials[-1]}" if index.positive?
      partials = partials.join(', ')
      format(INTRO, day, partials)
    end

    song.join("\n\n") + "\n"
  end
end
