require 'date'

class Meetup
  SCHEDULE_TO_INDEX = {
    first: 0,
    second: 1,
    third: 2,
    fourth: 3,
    last: -1
  }.freeze

  def initialize(month, year)
    @month = month
    @year = year
  end

  def day(day_of_week, schedule)
    case schedule
    when :teenth
      (13..19).each do |i|
        date = Date.new(@year, @month, i)
        return date if date.send("#{day_of_week}?")
      end
    else
      date = Date.new(@year, @month, 1)
      days_in_month = (date.next_month - 1).day
      weekdays = (1..days_in_month).select do |i|
        Date.new(@year, @month, i).send("#{day_of_week}?")
      end
      day = weekdays[SCHEDULE_TO_INDEX[schedule]]
      Date.new(@year, @month, day)
    end
  end
end
