class ListOps
  def self.arrays(arr)
    counter = 0
    arr.each do |_|
      counter += 1
    end
    counter
  end

  def self.reverser(arr)
    reversed = []
    arr.size.times do |index|
      reversed[index] = arr[-(index + 1)]
    end
    reversed
  end

  def self.concatter(arr1, arr2)
    [*arr1, *arr2]
  end

  def self.mapper(arr, &block)
    mapped = []
    arr.each do |element|
      mapped.push(block.call(element))
    end
    mapped
  end

  def self.filterer(arr, &block)
    filtered = []
    arr.each do |element|
      filtered.push(element) if block.call(element)
    end
    filtered
  end

  def self.sum_reducer(arr)
    sum = 0
    arr.each do |element|
      sum += element
    end
    sum
  end

  def self.factorial_reducer(arr)
    fact = 1
    arr.each do |element|
      fact *= element
    end
    fact
  end
end
