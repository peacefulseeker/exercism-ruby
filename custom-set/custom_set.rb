class CustomSet
  def initialize(array = [])
    @set = array.uniq
  end

  def to_s
    set
  end

  def ==(other)
    other.class == self.class && set.sort == other.to_s.sort
  end

  def add(element)
    self.class.new(set << element)
  end

  def empty?
    set.empty?
  end

  def member?(element)
    set.include?(element)
  end

  def subset?(other)
    difference(other).empty?
  end

  def disjoint?(other)
    intersection(other).empty?
  end

  def intersection(other)
    self.class.new(set & other.to_s)
  end

  def -(other)
    self.class.new(set - other.to_s)
  end

  def +(other)
    self.class.new(set + other.to_s)
  end

  private

  attr_reader :set

  alias union :+
  alias difference :-
  alias eql? :==
  alias inspect to_s
end
