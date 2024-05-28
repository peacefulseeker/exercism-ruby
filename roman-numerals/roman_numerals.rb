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
    if number - 5 >= 1
      ARABIC_TO_ROMAN[5] + ARABIC_TO_ROMAN[1] * (number - 5)
    else
      ARABIC_TO_ROMAN[1] * number
    end
  end

  def get_up_to_fifty(number)
    case number
    when 40..49
      ARABIC_TO_ROMAN[40] + (number % 10).to_roman
    else
      tens = number / 10
      ARABIC_TO_ROMAN[10] * tens + (number % 10).to_roman
    end
  end

  def get_up_to_hundred(number)
    case number
    when 90..99
      ARABIC_TO_ROMAN[90] + (number % 90).to_roman
    else
      ARABIC_TO_ROMAN[50] + (number % 50).to_roman
    end
  end

  def get_up_to_five_hundred(number)
    case number
    when 400..499
      ARABIC_TO_ROMAN[400] + (number % 400).to_roman
    else
      hundreds = number / 100
      ARABIC_TO_ROMAN[100] * hundreds + (number % 100).to_roman
    end
  end

  def get_up_to_thoudsand(number)
    case number
    when 900..999
      ARABIC_TO_ROMAN[900] + (number % 900).to_roman
    else
      ARABIC_TO_ROMAN[500] + (number - 500).to_roman
    end
  end

  def get_thousands(number)
    thousands = number / 1000
    ARABIC_TO_ROMAN[1000] * thousands + (number % 1000).to_roman
  end

  def to_roman
    return ARABIC_TO_ROMAN[self] if ARABIC_TO_ROMAN.key?(self)

    if self < 10
      get_tens(self)
    elsif self < 50
      get_up_to_fifty(self)
    elsif self < 100
      get_up_to_hundred(self)
    elsif self < 500
      get_up_to_five_hundred(self)
    elsif self < 1000
      get_up_to_thoudsand(self)
    else
      get_thousands(self)
    end
  end
end

# based on https://exercism.org/tracks/ruby/exercises/roman-numerals/solutions/nickharvey27
class IntegerSmart
  ARABIC_TO_ROMAN = {
    1000 => 'M',
    900 => 'CM',
    500 => 'D',
    400 => 'CD',
    100 => 'C',
    90 => 'XC',
    50 => 'L',
    40 => 'XL',
    10 => 'X',
    9 => 'IX',
    5 => 'V',
    4 => 'IV',
    1 => 'I'
  }.freeze

  def to_roman
    number = self

    ARABIC_TO_ROMAN.each.with_object('') do |(arabic, roman), str|
      # e.g. number = 166('CLXVI' expected)
      # skip for arabic => 400..1000+
      # 166 >= 100, yes.
      #   s = 'C'; 166 - 100 = 66
      # 66 >= 100, no. skip
      # 66 >= 50, yes
      #   s = 'CL'; 66 - 50 = 16
      # 16 >= 50, no. skip
      # 16 >= 40, no. skip
      # 16 >= 10, yes.
      #   s = 'CLX'; 16 - 10 = 6
      # 6 >= 10, no. skip
      # 6 >= 5, yes
      #   s = 'CLXV'; 6 - 5 = 1
      # 1 >= 5, no. skip
      # 1 >= 4, no. skip
      # 1 >= 1, yes
      #   s = 'CLXVI'; 1 - 1 = 0
      # 0 >= 1, no. skip, loop closes since there's no arabic left
      # s = 'CLXVI' returned here
      while number >= arabic
        str << roman
        number -= arabic
      end
    end
  end
end
