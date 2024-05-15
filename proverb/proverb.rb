class Proverb
  SAYING = 'For want of a %<first>s the %<second>s was lost.'.freeze
  FINAL = 'And all for the want of a %<final>s.'.freeze

  attr_reader :verses

  def initialize(*args, **kwargs)
    @verses = []

    generate_verses(*args, **kwargs)
  end

  def to_s
    verses.join("\n")
  end

  private

  def generate_verses(*args, **kwargs)
    (args.count - 1).times do |index|
      @verses << format(SAYING, first: args[index].to_s, second: args[index + 1].to_s)
    end
    @verses << if kwargs.key?(:qualifier)
                 format(FINAL, final: "#{kwargs[:qualifier]} #{args[0]}")
               else
                 format(FINAL, final: args[0].to_s)
               end
  end
end
