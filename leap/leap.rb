require 'date'

class Year
  def self._leap?(year)
    return unless (year % 4).zero?

    (year % 100).zero? ? (year % 400).zero? : true
  end

  def self.leap?(year)
    date = Date.new(year, 2, 28)
    (date + 1).day == 29
  end
end
