class Nucleotide
  ALLOWED = %w[A C G T].freeze

  def self.from_dna(dna)
    raise ArgumentError unless dna.chars.all? { |char| ALLOWED.include?(char) }

    new(dna).from_dna
  end

  def initialize(dna)
    @dna = ALLOWED.each_with_object({}) { |char, hash| hash[char] = dna.chars.count(char) }
  end

  def from_dna
    self
  end

  def count(char)
    @dna[char]
  end

  def histogram
    @dna
  end
end
