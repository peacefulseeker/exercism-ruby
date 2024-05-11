# with inspirations from https://exercism.org/tracks/ruby/exercises/bob/solutions/pgaspar

class Bob
  def self.hey(remark)
    new(remark).hey
  end

  def hey
    return ANSWERS[:QUESTION_YELL] if matches_yelling_question
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
    # letters = remark.scan(/\w/).join.scan(/[^\d]/)
    # letters.any? && letters.all? { |letter| letter.match?(/[A-Z]/) }

    remark.match(/[A-Z]/) && !remark.match(/[a-z]/)
  end

  def matches_question
    # match = remark.match(/^.+\?$/).to_a
    # match[0] == remark

    remark.end_with?('?')
  end

  def matches_yelling_question
    matches_question && matches_yell
  end

  def matches_silence
    # remark.scan(/\w/).empty?
    # could potentially be just empty? check since strip already
    # takes care of any whitespace chars. (\n\t\s\r)
    remark.empty?
  end
end

# https://exercism.org/tracks/ruby/exercises/bob/solutions/kotp
class BobKotp
  Response = {
    silence: 'Fine. Be that way!',
    yelling: 'Whoa, chill out!',
    asking: 'Sure.',
    statement: 'Whatever.',
    asking_loudly: "Calm down, I know what I'm doing!"
  }.freeze

  Silence = lambda do |t|
    t.gsub(/\s/, '').empty?
  end
  Asking = lambda do |t|
    t =~ /\?\z/
  end
  Yelling = lambda do |t|
    t == t.upcase && t =~ /[A-Z]/
  end
  AskingLoudly = lambda do |t|
    Asking[t] && Yelling[t]
  end

  def self.hey(phrase)
    Bob.new.hey(phrase)
  end

  def hey(text)
    @phrase = text
    Response[statement_style]
  end

  private

  def statement_style
    case @phrase.strip
    when AskingLoudly
      :asking_loudly
    when Yelling
      :yelling
    when Silence
      :silence
    when Asking
      :asking
    else
      :statement
    end
  end
end
