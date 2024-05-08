class FlattenArray
  def self.flatten(array)
    new.flatten(array)
  end

  def flatten(array)
    # easy
    # array.flatten.reject(&:nil?)

    iterate_array(array)
  end

  def iterate_array(array, flattened = [])
    array.map do |item|
      if item.is_a? Array
        iterate_array(item, flattened)
      else
        flattened.push(item) unless item.nil?
      end
    end

    flattened
  end
end
