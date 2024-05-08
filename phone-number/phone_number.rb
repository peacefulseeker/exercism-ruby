class PhoneNumber
  EXPECTED_FORMAT = /^[2-9]\d{2}[2-9]\d{6}$/

  def self.clean_(number)
    # brute force
    digits_only = number.scan(/\d/).join
    digits_only_without_1 = digits_only.sub(/^1/, '')

    return nil if digits_only_without_1.length != 10
    return nil if [digits_only_without_1[0], digits_only_without_1[3]].any? { |d| !d.match(/[2-9]/) }

    digits_only_without_1
  end

  # inspired by https://exercism.org/tracks/ruby/exercises/phone-number/solutions/danshock
  def self.clean(number)
    digits = number.scan(/\d/).join.sub(/^1/, '')
    digits[EXPECTED_FORMAT]
  end
end
