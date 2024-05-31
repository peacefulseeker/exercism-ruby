class Microwave
  attr_reader :time

  def initialize(time)
    @time = time
  end

  def get_minutes_and_seconds(minutes, seconds)
    extra_minutes = seconds / 60
    seconds -= extra_minutes * 60
    minutes += extra_minutes

    [minutes, seconds]
  end

  def timer
    digits = time.to_s.chars
    if digits.count == 3
      minutes, seconds = get_minutes_and_seconds(digits[0].to_i, digits[1..].join.to_i)
    elsif digits.count == 4
      minutes, seconds = get_minutes_and_seconds(digits[0..1].join.to_i, digits[2..].join.to_i)
    else
      minutes = time / 60
      seconds = time % 60
    end
    format('%<minutes>02d:%<seconds>02d', minutes:, seconds:)
  end
end
