class Allergies
  ALLERGIES = {
    eggs: 1,
    peanuts: 2,
    shellfish: 4,
    strawberries: 8,
    tomatoes: 16,
    chocolate: 32,
    pollen: 64,
    cats: 128
  }.freeze

  def initialize(score)
    @next_allergy_value = 2 * ALLERGIES.values.max
    @score = score % @next_allergy_value
  end

  def allergic_to?(allergy)
    list.include?(allergy)
  end

  def list
    result = []
    allergies = ALLERGIES.select { |_, v| v <= @score }
    allergies.reverse_each do |key, value|
      if @score >= value
        @score -= value
        result << key.to_s
      end
    end

    result.reverse
  end
end
