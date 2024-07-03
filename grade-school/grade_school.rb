require 'ostruct'

class School
  def initialize
    @registry = {}
  end

  def sorted
    @registry.sort_by { |name, grade| [grade, name] }
  end

  def grade(grade)
    sorted.select { |_, g| g == grade }.map(&:first)
  end

  def roster
    sorted.map(&:first)
  end

  def add(name, grade)
    return false if @registry.key?(name)

    !!(@registry[name] = grade)
  end
end
