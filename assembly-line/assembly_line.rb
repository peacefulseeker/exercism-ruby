class AssemblyLine
  RATES = {
    1..4 => 1,
    5..8 => 0.9,
    9..9 => 0.8,
    10..10 => 0.77,
  }

  CARS_PER_HOUR = 221
  CARS_PER_MINUTE_COMPLETED = CARS_PER_HOUR / 60

  # 221 / 60.to_f -> if float would be needed (OR 221.to_f / 60)

  def initialize(speed)
    @speed = speed
  end

  def success_rate
    RATES.select { |range, _| range.cover?(@speed) }.values.first
  end

  def production_rate_per_hour
    CARS_PER_HOUR * @speed * success_rate
  end

  def working_items_per_minute
    (production_rate_per_hour / 60).floor
  end
end
