class WordProblem
  class QuestionError < ArgumentError
    def initialize(message = "I don't understand the question")
      super
    end
  end

  OPERATION_TO_METHOD = {
    'plus' => :+,
    'minus' => :-,
    'multiplied' => :*,
    'divided' => :/
  }.freeze

  def initialize(question)
    @question = question
  end

  def answer
    # -3 plus 7 multiplied by -2
    expression = @question.scan(/-?\d.+-?\d/).first
    raise QuestionError if expression.nil?

    # ["-3", "plus", "7", "multiplied" "-2"]
    # TODO: get rid of that reject by constructing a bit more complex regex
    symbols = expression.split(/\s+/).reject { |i| i == 'by' }

    first = symbols[0].to_i
    symbols[1..].each_slice(2).inject(first) do |sum, (op, a)|
      operation = OPERATION_TO_METHOD[op]
      sum.send(operation, a.to_i)
    end
  end
end

# https://exercism.org/tracks/ruby/exercises/wordy/solutions/gchan
# smart to combine numvers and operations
# with unshifting + in front
class WordProblemGchan
  attr_reader :question

  OPERATIONS = {
    'plus' => :+,
    'minus' => :-,
    'divided' => :/,
    'multiplied' => :*
  }

  def initialize(question)
    @question = question
  end

  def answer
    numbers = question.scan(/(-?\d+)/).flatten.map(&:to_i)

    operations = question.scan(/(plus|minus|multiplied|divided)/).flatten
                         .map { |op| OPERATIONS[op] }

    raise ArgumentError if numbers.empty? || operations.empty?

    equation = operations.unshift(:+).zip(numbers).flatten.compact

    equation.each_slice(2).inject(0) do |sum, (operation, number)|
      sum.send(operation, number)
    end
  end
end
