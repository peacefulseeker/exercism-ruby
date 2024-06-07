require 'date'

class Meetup
  SCHEDULE_TO_INDEX = {
    first: 0,
    second: 1,
    third: 2,
    fourth: 3,
    last: -1
  }.freeze
  TEENTH_DAY_RANGE = (13..19)

  def initialize(month, year)
    @month = month
    @year = year
  end

  def day(day_of_week, schedule)
    dates = dates(day_of_week)
    case schedule
    when :teenth
      dates.find { |date| TEENTH_DAY_RANGE.include?(date.day) }
    else
      dates[SCHEDULE_TO_INDEX[schedule]]
    end
  end

  def dates(day_of_week)
    1.upto(days_in_month)
     .map { |day| Date.new(@year, @month, day) }
     .select { |date| date.send("#{day_of_week}?") }
  end

  def days_in_month
    Date.new(@year, @month, -1).day
  end
end
