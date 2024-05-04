class SpaceAge
  ONE_YEAR_ON_EARTH_IN_SECONDS = (60 * 60 * 24 * 365.25).to_f.freeze

  PLANET_AGE_RATIO = {
    'earth' => 1,
    'mercury' => 0.2408467,
    'venus' => 0.61519726,
    'mars' => 1.8808158,
    'jupiter' => 11.862615,
    'saturn' => 29.447498,
    'uranus' => 84.016846,
    'neptune' => 164.79132
  }.freeze

  def initialize(seconds)
    @seconds = seconds
  end

  # def on_earth
  # def on_mercury
  # def on_venus
  # and so on
  PLANET_AGE_RATIO.each do |planet, ratio|
    define_method "on_#{planet}" do
      @seconds / (ratio * ONE_YEAR_ON_EARTH_IN_SECONDS).to_f
    end
  end
end
