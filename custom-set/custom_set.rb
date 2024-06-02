class CustomSet
  def initialize(array = [])
    @set = array.uniq.sort
  end

  def to_s
    set
  end

  def ==(other)
    self.class == other.class && set == other.to_s
  end

  def add(element)
    self.class.new(set + [element])
  end

  def empty?
    set.empty?
  end

  def member?(element)
    set.include?(element)
  end

  def subset?(other)
    set.all? { |element| other.member? element }
  end

  def disjoint?(other)
    set.none? { |element| other.member? element }
  end

  def intersection(other)
    match = set.filter { |element| other.member? element }
    self.class.new(match)
  end

  def -(other)
    diff = set.filter { |element| !other.member? element }
    self.class.new(diff)
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
