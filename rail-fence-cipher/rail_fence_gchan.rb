# https://exercism.org/tracks/ruby/exercises/rail-fence-cipher/solutions/gchan
# how come??? so freaking elegant.
class RailFenceCipher
  VERSION = 1

  def self.decode(ciphertext, rails)
    zigzag(rails, ciphertext.length)
      .sort
      .zip(ciphertext.chars)
      .sort_by { |a| a[0][1] }
      .map { |a| a[1] }
      .join
  end

  def self.encode(plaintext, rails)
    zigzag(rails, plaintext.length)
      .zip(plaintext.chars)
      .sort
      .map { |a| a[1] }
      .join
  end

  def self.zigzag(rails, size)
    pattern = (0..rails - 1).to_a + (1..rails - 2).to_a.reverse
    # not sure why not just pattern.take(size)
    pattern.cycle.first(size).zip(0..size)
  end
end
