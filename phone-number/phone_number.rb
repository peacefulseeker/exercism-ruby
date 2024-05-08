class PhoneNumber
  def self.clean(number)
    # brute force
    digits_only = number.scan(/\d/).join
    digits_only_without_1 = digits_only.sub(/^1/, '')

    return nil if digits_only_without_1.length != 10
    return nil if [digits_only_without_1[0], digits_only_without_1[3]].any? { |d| !d.match(/[2-9]/) }

    digits_only_without_1

    # TODO: regex approach
  end
end
