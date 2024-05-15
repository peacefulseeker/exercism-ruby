class Nucleotide
  NUCLEOTIDES = %w[A C G T].freeze
  # dynamic way of generating 0 for each nucleotide in hash
  # EMPTY_HISTOGRAM = NUCLEOTIDES.zip([0] * NUCLEOTIDES.size).to_h

  def self.from_dna(strand)
    # raise ArgumentError unless strand.chars.all? { |char| NUCLEOTIDES.include?(char) }
    # =~ will return the position of the element which does not match the ones in the group
    raise NucleotideError if strand =~ /[^GTAC]/

    new(strand)
  end

  def initialize(strand)
    @dna = NUCLEOTIDES.each_with_object({}) { |char, hash| hash[char] = strand.count(char) }
  end

  def count(char)
    @dna[char]
  end

  def histogram
    @dna
  end
end

# kotp: https://exercism.org/tracks/ruby/exercises/nucleotide-count/solutions/kotp
class NucleotideError < ArgumentError
  def message
    message || 'Given strand is does not look like a nucleotide strand'
  end
end
