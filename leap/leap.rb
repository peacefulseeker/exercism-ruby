class Year
  def self.leap?(year)
    return unless (year % 4).zero?

    (year % 100).zero? ? (year % 400).zero? : true
  end
end
