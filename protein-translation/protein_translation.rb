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
    result = []
    strand.chars.each_slice(3).map(&:join).each do |codon|
      _, protein = CODON_TO_PROTEIN.find { |c, _| c.include? codon }
      return result if protein == 'STOP'

      raise InvalidCodonError unless CODONS.include? codon

      result << protein
    end

    result
  end
end
