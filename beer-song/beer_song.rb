class BeerSong
  VERSE = <<~TEXT
    %<start_bottles>d bottles of beer on the wall, %<start_bottles>d bottles of beer.
    Take one down and pass it around, %<left_bottles>s of beer on the wall.
  TEXT

  VERSE_ONE_BOTTLE = <<~TEXT
    1 bottle of beer on the wall, 1 bottle of beer.
    Take it down and pass it around, no more bottles of beer on the wall.
  TEXT

  VERSE_ZERO_BOTTLES = <<~TEXT
    No more bottles of beer on the wall, no more bottles of beer.
    Go to the store and buy some more, 99 bottles of beer on the wall.
  TEXT

  def self.recite(verse, count)
    new.recite(verse, count)
  end

  # inspired by https://exercism.org/tracks/ruby/exercises/beer-song/solutions/ajoshguy
  def recite(start_bottles, take_bottles)
    take_bottles.times.map { |bottle| verse(start_bottles - bottle) }.join("\n")
  end

  def verse(bottles)
    if bottles == 1
      VERSE_ONE_BOTTLE
    elsif bottles.zero?
      VERSE_ZERO_BOTTLES
    else
      format(VERSE, start_bottles: bottles, left_bottles: bottles_left(bottles - 1))
    end
  end

  def bottles_left(bottles)
    left_bottles_str = "#{bottles} bottle"
    left_bottles_str += 's' if bottles > 1
    left_bottles_str
  end
end
