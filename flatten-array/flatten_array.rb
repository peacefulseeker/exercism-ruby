class FlattenArray
  def self.flatten(array)
    new.flatten(array)
  end

  def flatten(array)
    # easy
    # array.flatten.reject(&:nil?)
    # array.flatten.compact

    iterate_array(array)
  end

  def iterate_array(array, flattened = [])
    array.map do |item|
      if item.is_a? Array
        iterate_array(item, flattened)
      else
        flattened << item unless item.nil?
      end
    end

    flattened
  end

  # https://exercism.org/tracks/ruby/exercises/flatten-array/solutions/toyseed
  def iterate_array2(array)
    array.each_with_object([]) do |item, flattened|
      if item.is_a? Array
        flattened.push(*iterate_array(item))
      else
        flattened << item unless item.nil?
      end
    end
  end
end
