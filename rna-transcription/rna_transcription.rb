class Complement
  # DNA_TO_RNA = {
  #   G: :C,
  #   C: :G,
  #   T: :A,
  #   A: :U
  # }
  def self.of_dna(dna)
    # dna.upcase.chars.map { |char| DNA_TO_RNA[char.to_sym] }.join

    dna.tr('GCTA', 'CGAU')
  end
end
