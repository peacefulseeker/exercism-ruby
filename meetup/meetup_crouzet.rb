require 'date'
# https://exercism.org/tracks/ruby/exercises/meetup/solutions/CROUZET
class Meetup
  attr_reader :days_of_the_month

  def initialize(month, year)
    @days_of_the_month = (Date.new(year, month)..Date.new(year, month).next_month.prev_day)
  end

  def day(day_name, specifier)
    case specifier
    when :first
      days_named(day_name).first
    when :second
      days_named(day_name)[1]
    when :third
      days_named(day_name)[2]
    when :fourth
      days_named(day_name)[3]
    when :last
      days_named(day_name).last
    when :teenth
      days_named(day_name).find { |day| teen?(day) }
    end
  end

  def days_named(name)
    days_of_the_month.select { |day| day.strftime('%A') == name.to_s.capitalize }
  end

  def teen?(day)
    (13..19).include?(day.day)
  end
end
