class Integer
  ARABIC_TO_ROMAN = {
    1 => 'I',
    4 => 'IV',
    5 => 'V',
    9 => 'IX',
    10 => 'X',
    40 => 'XL',
    50 => 'L',
    90 => 'XC',
    100 => 'C',
    400 => 'CD',
    500 => 'D',
    900 => 'CM',
    1000 => 'M'
  }.freeze

  def get_tens(number)
    return ARABIC_TO_ROMAN[number] if ARABIC_TO_ROMAN.key?(number)

    if number - 5 >= 1
      ARABIC_TO_ROMAN[5] + ARABIC_TO_ROMAN[1] * (number - 5)
    else
      ARABIC_TO_ROMAN[1] * number
    end
  end

  def get_fivties(number)
    return ARABIC_TO_ROMAN[number] if ARABIC_TO_ROMAN.key?(number)

    case number
    when 40..49
      ARABIC_TO_ROMAN[40] + get_tens(number % 10)
    else
      tens = number / 10
      ARABIC_TO_ROMAN[10] * tens + get_tens(number % 10)
    end
  end

  def get_hundreds(number)
    return ARABIC_TO_ROMAN[number] if ARABIC_TO_ROMAN.key?(number)

    case number
    when 90..99
      ARABIC_TO_ROMAN[90] + (number % 90).to_roman
    else
      ARABIC_TO_ROMAN[50] + (number % 50).to_roman
    end
  end

  def get_five_hundreds(number)
    return ARABIC_TO_ROMAN[number] if ARABIC_TO_ROMAN.key?(number)

    case number
    when 400..499
      ARABIC_TO_ROMAN[400] + (number % 400).to_roman
    else
      hundreds = number / 100
      ARABIC_TO_ROMAN[100] * hundreds + (number % 100).to_roman
    end
  end

  def get_thousands(number)
    return ARABIC_TO_ROMAN[number] if ARABIC_TO_ROMAN.key?(number)

    case number
    when 900..999
      ARABIC_TO_ROMAN[900] + (number % 900).to_roman
    else
      ARABIC_TO_ROMAN[500] + (number - 500).to_roman
    end
  end

  def get_ten_thousands(number)
    return ARABIC_TO_ROMAN[number] if ARABIC_TO_ROMAN.key?(number)

    thousands = number / 1000
    ARABIC_TO_ROMAN[1000] * thousands + (number % 1000).to_roman
  end

  def to_roman
    return ARABIC_TO_ROMAN[self] if ARABIC_TO_ROMAN.key?(self)

    if self < 10
      get_tens(self)
    elsif self < 50
      get_fivties(self)
    elsif self < 100
      get_hundreds(self)
    elsif self < 500
      get_five_hundreds(self)
    elsif self < 1000
      get_thousands(self)
    else
      get_ten_thousands(self)
    end
  end
end
