class ComplexNumber
  def initialize(real, imaginary = 0)
    @real = real
    @imaginary = imaginary
  end

  attr_accessor :real, :imaginary

  def ==(other)
    (self - other).abs < 1e-15 # diff not greater than 10^-15, 0.000000000000001
  end

  def exp
    ComplexNumber.new(Math.exp(@real)) * ComplexNumber.new(Math.cos(@imaginary), Math.sin(@imaginary))
  end

  def *(other)
    real = @real * other.real - @imaginary * other.imaginary
    imaginary = @imaginary * other.real + @real * other.imaginary

    ComplexNumber.new(real, imaginary)
  end

  def abs
    Math.sqrt(real**2 + imaginary**2)
  end

  def conjugate
    ComplexNumber.new(real, -imaginary)
  end

  def /(other)
    real = (@real * other.real + @imaginary * other.imaginary).fdiv(other.real**2 + other.imaginary**2)
    imaginary = (@imaginary * other.real - @real * other.imaginary).fdiv(other.real**2 + other.imaginary**2)

    ComplexNumber.new(real, imaginary)
  end

  def +(other)
    real = @real + other.real
    imaginary = @imaginary + other.imaginary

    ComplexNumber.new(real, imaginary)
  end

  def -(other)
    real = @real - other.real
    imaginary = @imaginary - other.imaginary

    ComplexNumber.new(real, imaginary)
  end
end
