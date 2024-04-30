class Hamming
  def self.compute(strand1, strand2)
    raise ArgumentError if strand1.length != strand2.length

    # brute force
    # counter = 0
    # strand1.each_char.with_index do |char, index|
    #   counter += 1 if char != strand2[index]
    # end
    # counter

    #  array pair zipping
    # zipping each item of one array with the corresponding item of the other array
    # using count block method to compare each pair and count diffs
    # https://exercism.org/tracks/ruby/exercises/hamming/solutions/vrand
    strand1.chars.zip(strand2.chars).count { |a, b| a != b }

    # Counting diffs by array item references(using indices)
    # https://exercism.org/tracks/ruby/exercises/hamming/solutions/dzivalli
    # (0...strand1.length).count { |i| strand1[i] != strand2[i] }
    # same as
    # strand1.length.times.count { |i| strand1[i] != strand2[i] }
  end
end
