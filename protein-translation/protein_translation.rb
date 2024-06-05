class InvalidCodonError < StandardError; end

class Translation
  CODON_TO_PROTEIN = {
    %w[AUG] => 'Methionine',
    %w[UUU UUC] => 'Phenylalanine',
    %w[UUA UUG] => 'Leucine',
    %w[UCU UCC UCA UCG] => 'Serine',
    %w[UAU UAC] => 'Tyrosine',
    %w[UGU UGC] => 'Cysteine',
    %w[UGG] => 'Tryptophan',
    %w[UAA UAG UGA] => 'STOP'
  }.freeze
  CODONS = CODON_TO_PROTEIN.keys.reduce(:+)

  def self.of_rna(strand)
    strand.chars.each_slice(3).with_object([]) do |codon, result|
      _, protein = CODON_TO_PROTEIN.find { |c, _| c.include? codon.join }
      return result if protein == 'STOP'

      raise InvalidCodonError unless CODONS.include? codon.join

      result << protein
    end
  end
end

# https://exercism.org/tracks/ruby/exercises/protein-translation/solutions/unused
class TranslationWithLookup
  LOOKUP = {
    'Methionine' => %w[AUG],
    'Phenylalanine' => %w[UUU UUC],
    'Leucine' => %w[UUA UUG],
    'Serine' => %w[UCU UCC UCA UCG],
    'Tyrosine' => %w[UAU UAC],
    'Cysteine' => %w[UGU UGC],
    'Tryptophan' => %w[UGG],
    'STOP' => %w[UAA UAG UGA]
  }.freeze

  def self.of_rna(strand)
    return [] if strand.empty?

    split(strand).inject([]) do |proteins, s|
      protein = lookup(s) || raise(InvalidCodonError)
      return proteins if protein == 'STOP'

      proteins << protein
    end
  end

  def self.lookup(strand)
    LOOKUP.find { |_, codon| codon.include? strand }&.first
  end

  def self.split(strand)
    strand.chars.each_slice(3).map(&:join)
  end
end
