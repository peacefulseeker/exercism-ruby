class Hamming
  def self.compute(strand1, strand2)
    raise ArgumentError if strand1.length != strand2.length

    counter = 0
    strand1.each_char.with_index do |char, index|
      counter += 1 if char != strand2[index]
    end
    counter
  end
end
