# https://exercism.org/tracks/ruby/exercises/meetup/solutions/jlcrochet
class Meetup
  def initialize(month, year)
    @month = month
    @year = year
    @first_date = Date.new(@year, @month)
    @last_date = (@first_date >> 1) - 1
  end

  def day(d, descriptor)
    (@first_date..@last_date).find do |date|
      date.send("#{d}?") && send("#{descriptor}?", date.day)
    end
  end

  private

  def teenth?(n)
    n.between?(13, 19)
  end

  def first?(n)
    n.between?(1, 7)
  end

  def second?(n)
    n.between?(8, 14)
  end

  def third?(n)
    n.between?(15, 21)
  end

  def fourth?(n)
    n.between?(22, 28)
  end

  def last?(n)
    n.between?(@last_date.day - 6, @last_date.day)
  end
end
