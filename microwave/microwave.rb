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

  def timer_
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

  # https://exercism.org/tracks/ruby/exercises/microwave/solutions/valloskut
  def timer
    minutes, seconds = time.divmod(100)
    minutes_overflow, seconds = seconds.divmod(60)
    format('%<minutes>02d:%<seconds>02d', minutes: minutes + minutes_overflow, seconds:)
  end
end

# https://exercism.org/tracks/ruby/exercises/microwave/solutions/emlozin
# smart minutes / seconds extraction + Time.at constructor leveraging
class MicrowaveTime
  def initialize(time)
    seconds = time % 100
    minutes = time / 100 * 60
    @time = Time.at(seconds + minutes).utc
  end

  def timer
    @time.strftime('%M:%S')
  end
end
