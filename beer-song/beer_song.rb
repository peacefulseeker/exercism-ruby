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

  def self.recite(start_bottles, take_bottles)
    verses = []

    take_bottles.times do
      verses << if start_bottles == 1
                  VERSE_ONE_BOTTLE
                elsif start_bottles.zero?
                  VERSE_ZERO_BOTTLES
                else
                  left_bottles = start_bottles - 1
                  left_bottles_str = "#{left_bottles} bottle"
                  left_bottles_str += 's' if left_bottles > 1
                  format(VERSE, start_bottles:, left_bottles: left_bottles_str)
                end
      start_bottles += -1
    end

    verses.join("\n")
  end
end
