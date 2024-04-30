class Raindrops
  def self.convert(number)
    string = ''
    # alternative string compsing
    # string << 'Pling' if (number % 3).zero?
    string += 'Pling' if (number % 3).zero?
    string += 'Plang' if (number % 5).zero?
    string += 'Plong' if (number % 7).zero?

    string.empty? ? number.to_s : string
  end
end
