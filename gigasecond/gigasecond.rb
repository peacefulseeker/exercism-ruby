class Gigasecond
  # A gigasecond is one thousand million seconds
  GIGASECOND = 1_000_000_000

  def self.from(date)
    # Time.at(date.to_i + GIGASECOND)
    # will handle conversion automatically
    date + GIGASECOND
  end
end
