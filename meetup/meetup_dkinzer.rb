require 'date'
# https://exercism.org/tracks/ruby/exercises/meetup/solutions/dkinzer

class Meetup
  class Days < Array
    TEENS = (13..19)

    def second
      self[1]
    end

    def third
      self[2]
    end

    def fourth
      self[3]
    end

    def teenth
      find { |d| TEENS.include? d.day }
    end
  end

  def initialize(month, year)
    day = Date.new(year, month)
    @days = (day..day.next_month.prev_day).to_a
  end

  def day(day, type)
    Days.new(@days.select { |d| d.send("#{day}?") }).send(type)
  end
end
