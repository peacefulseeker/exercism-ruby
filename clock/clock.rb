class Clock
  attr_reader :total_minutes

  def initialize(hour: 0, minute: 0)
    @hour = hour
    @minute = minute
    @total_minutes = @hour * 60 + @minute
  end

  def to_s
    hours, minutes = hours_and_minutes
    time = ''
    time << (hours < 10 ? "0#{hours}:" : "#{hours}:")
    time << (minutes < 10 ? "0#{minutes}" : minutes.to_s)
    time
  end

  def ==(other)
    self.class == other.class && to_s == other.to_s
  end

  def +(other)
    Clock.new(minute: total_minutes + other.total_minutes)
  end

  def -(other)
    Clock.new(minute: total_minutes - other.total_minutes)
  end

  private

  def hours_and_minutes
    hours = (total_minutes / 60) % 24
    minutes = total_minutes % 60

    [hours, minutes]
  end
end

# very smart way of reusing minutes only when comparing
# Author: https://exercism.org/tracks/ruby/exercises/clock/solutions/Tgomolko
class Clock__
  attr_accessor :total_minutes

  def initialize(hour: 0, minute: 0)
    minutes_in_day = 60 * 24
    @total_minutes = (hour * 60 + minute).modulo(minutes_in_day) # .modulo == %
  end

  def to_s
    # Numeric.divmod(n) Returns a 2-element array [q, r], where
    # q = (self/other).floor    # Quotient
    # r = self % other          # Remainder
    hours, minutes = total_minutes.divmod(60)
    format('%02d:%02d', hours, minutes)
    # or using String.rjust method
    # "#{hours.to_s.rjust(2, '0')}:#{minutes.to_s.rjust(2, '0')}"
  end

  def +(other)
    Clock.new(minute: total_minutes + other.total_minutes)
  end

  def -(other)
    Clock.new(minute: total_minutes - other.total_minutes)
  end

  def ==(other)
    other.class == self.class &&
      other.total_minutes == total_minutes
  end
end
