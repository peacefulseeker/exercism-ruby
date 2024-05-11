class Bob
  def self.hey(remark)
    new(remark).hey
  end

  def hey
    return ANSWERS[:QUESTION_YELL] if matches_question && matches_yell
    return ANSWERS[:QUESTION] if matches_question
    return ANSWERS[:YELL] if matches_yell
    return ANSWERS[:SILENCE] if matches_silence

    ANSWERS[:DEFAULT]
  end

  private

  ANSWERS = {
    QUESTION: 'Sure.',
    QUESTION_YELL: 'Calm down, I know what I\'m doing!',
    YELL: 'Whoa, chill out!',
    SILENCE: 'Fine. Be that way!',
    DEFAULT: 'Whatever.'
  }.freeze

  attr_reader :remark

  def initialize(remark)
    @remark = remark.strip
  end

  def matches_yell
    letters = remark.scan(/\w/).join.scan(/[^\d]/)
    letters.any? && letters.all? { |letter| letter.match?(/[A-Z]/) }
  end

  def matches_question
    match = remark.match(/^.+\?$/).to_a
    match[0] == remark
  end

  def matches_silence
    remark.scan(/\w/).empty?
  end
end
