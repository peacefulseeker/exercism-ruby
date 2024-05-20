# https://exercism.org/tracks/ruby/exercises/allergies/solutions/ajoshguy
module Bits
  refine Integer do
    # bite shifting alternative
    # 1 << 1 => 2
    # 1 << 2 => 4
    # 1 << 3 => 8
    def bit
      # 1 << self
      2**self
    end
  end
end

class Allergies
  using Bits
  ALLERGIES = {
    eggs: 0.bit,
    peanuts: 1.bit,
    shellfish: 2.bit,
    strawberries: 3.bit,
    tomatoes: 4.bit,
    chocolate: 5.bit,
    pollen: 6.bit,
    cats: 7.bit
  }.transform_keys(&:to_s).freeze

  def initialize(score)
    @next_allergy_value = 2 * ALLERGIES.values.max
    @score = score % @next_allergy_value
  end

  def allergic_to?(allergy)
    # list.include?(allergy)
    # bitwise AND https://ruby-doc.org/3.2.3/Integer.html#method-i-26
    @score & ALLERGIES[allergy] != 0
  end

  def list
    # result = []
    # allergies = ALLERGIES.select { |_, v| v <= @score }
    # allergies.reverse_each do |key, value|
    #   if @score >= value
    #     @score -= value
    #     result << key
    #   end
    # end

    # result.reverse

    ALLERGIES.keys.select { |a| allergic_to?(a) }
  end
end
