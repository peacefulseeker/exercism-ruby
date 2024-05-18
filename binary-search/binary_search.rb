class BinarySearch
  def initialize(nums)
    @nums = nums
  end

  def search_for(num)
    left = 0
    right = @nums.length - 1
    while left <= right
      # division with flooring, which is good for indices
      mid = (left + right) / 2
      if num == @nums[mid]
        return mid
      elsif num > @nums[mid]
        left = mid + 1
      else
        right = mid - 1
      end
    end
  end
end
