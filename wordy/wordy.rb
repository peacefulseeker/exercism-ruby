class WordProblem
  OPERATIONS_TO_METHOD = {
    "plus": '+',
    "minus": '-',
    "multiplied by": '*',
    "divided by": '/'
  }.freeze

  def initialize(question)
    @question = question
  end

  def answer
    # -3 plus 7 multiplied by -2
    expression = @question.scan(/-?\d.+-?\d/).first
    raise ArgumentError if expression.nil?

    # -3 + 7 * -2
    OPERATIONS_TO_METHOD.each do |key, value|
      expression.gsub!(/#{key}/, value)
    end

    # ["-3", "+", "7", "*" "-2"]
    symbols = expression.split(/\s+/)

    result = symbols[0].to_i # -3
    symbols[1..].each_slice(2) do |op, a|
      result = result.send(op.to_sym, a.to_i)
    end

    result
  end
end
