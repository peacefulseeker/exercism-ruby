class Proverb
  SAYING = 'For want of a %<desire>s the %<loss>s was lost.'.freeze
  FINAL = 'And all for the want of a %<desire>s.'.freeze

  def initialize(*args, qualifier: '')
    @items = args
    @qualifier = qualifier
    @verses = generate_verses
  end

  def to_s
    @verses.join("\n")
  end

  private

  def generate_verses
    # (@items.count - 1).times do |index|
    #   @verses << format(SAYING, first: @items[index].to_s, second: @items[index + 1].to_s)
    # end

    [
      *@items.each_cons(2).map { |desire, loss| format(SAYING, desire:, loss:) },
      format(FINAL, desire: "#{@qualifier} #{@items.first}").squeeze(' ')
    ]
  end
end

# Learnt from
# https://exercism.org/tracks/ruby/exercises/proverb/solutions/iHiD
# https://exercism.org/tracks/ruby/exercises/proverb/solutions/BeggarsMattM
