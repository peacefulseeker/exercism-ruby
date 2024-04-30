# class Raindrops
#   def self.convert(number)
#     string = ''
#     # alternative string compsing
#     # string << 'Pling' if (number % 3).zero?
#     string += 'Pling' if (number % 3).zero?
#     string += 'Plang' if (number % 5).zero?
#     string += 'Plong' if (number % 7).zero?

#     string.empty? ? number.to_s : string
#   end
# end

# founder approach, extendible
# https://exercism.org/tracks/ruby/exercises/raindrops/solutions/iHiD
module Raindrops
  SOUNDS = { 3 => 'Pling', 5 => 'Plang', 7 => 'Plong' }.freeze
  def self.convert(num)
    rhythm = SOUNDS.select { |key, _| (num % key).zero? }.values
    rhythm.empty? ? num.to_s : rhythm.join
  end
end
