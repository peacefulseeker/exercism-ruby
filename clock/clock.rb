class Clock
  attr_reader :hour, :minute

  def initialize(hour: 0, minute: 0)
    @hour = hour
    @minute = minute
  end

  def to_s
    hours, minutes = hours_hours_and_minutes
    time = ''
    time << (hours < 10 ? "0#{hours}:" : "#{hours}:")
    time << (minutes < 10 ? "0#{minutes}" : minutes.to_s)
    time
  end

  def ==(other)
    to_s == other.to_s
  end

  def +(other)
    Clock.new(hour: hour + other.hour, minute: minute + other.minute)
  end

  def -(other)
    Clock.new(hour: hour - other.hour, minute: minute - other.minute)
  end

  private

  def hours_hours_and_minutes
    total_minutes = @hour * 60 + @minute
    hours = (total_minutes / 60) % 24
    minutes = total_minutes % 60

    [hours, minutes]
  end
end
