class ParallelLetterFrequency
  def self.count(texts)
    new(texts).count
  end

  def initialize(texts)
    @texts = texts
    @result = Hash.new(0)
  end

  def count
    threads = []
    @texts.each do |text|
      threads << Thread.new do
        step = [text.length / 5, 1].max
        (0..text.length).step(step).each do |index|
          chunk = text[index..(index - 1) + step]
          process(chunk)
        end
      end
    end

    threads.each(&:join)

    @result
  end

  def process(text)
    text.downcase.each_char do |char|
      @result[char] += 1 if char.match?(/\p{L}/)
    end
  end
end
