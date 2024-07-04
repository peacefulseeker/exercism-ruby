module RailFenceCipher
  class << self
    def encode(input, rails)
      return input if rails == 1

      walk = rail_walk(rails, input.size)
      rails = Array.new(rails) { '' }
      input.chars.zip(walk) do |char, rail|
        rails[rail] << char
      end

      rails.join
    end

    def decode(input, rails)
      return input if rails == 1

      walk = rail_walk(rails, input.size)
      lengths = rails.times.map { |rail| walk.count(rail) }
      offsets = lengths.each_with_object([0]) { |length, offsets| offsets << offsets.last + length } # rubocop:disable Lint/ShadowingOuterLocalVariable
      rails = lengths.zip(offsets).map { |length, offset| input[offset, length].chars }
      walk.map { |rail| rails[rail].shift }.join
    end

    private

    def rail_walk(rails, length)
      down = 0.upto(rails - 1)
      up = (rails - 2).downto(1)
      [*down, *up].cycle.first(length)
    end
  end
end
