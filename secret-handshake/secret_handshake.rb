class SecretHandshake
  COMMANDS = ['wink', 'double blink', 'close your eyes', 'jump'].freeze

  def initialize(command)
    @command = command
  end

  def commands
    return [] unless @command.instance_of?(Integer)

    actions = []
    binaries = @command.to_i.to_s(2)
    binaries.reverse.chars.each_with_index do |binary, index|
      actions << COMMANDS[index] if COMMANDS[index] && binary == '1'
    end
    actions.reverse! if binaries[0] == '1' && binaries.length == 5
    actions
  end
end

# https://exercism.org/tracks/ruby/exercises/secret-handshake/solutions/JIAZHEN
class SecretHandshakeJIAZHEN
  COMMANDS = {
    0 => ->(result) { result << 'wink' },
    1 => ->(result) { result << 'double blink' },
    2 => ->(result) { result << 'close your eyes' },
    3 => ->(result) { result << 'jump' },
    4 => ->(result) { result.reverse! }
  }.freeze

  def initialize(code)
    @code = code.to_s(2).reverse
  rescue ArgumentError
    @code = ''
  end

  def commands
    COMMANDS.each_with_object([]) do |(index, block), result|
      block.call(result) if @code[index] && @code[index] == '1'
    end
  end
end

# https://exercism.org/tracks/ruby/exercises/secret-handshake/solutions/henrik
class SecretHandshakeHenrik
  def initialize(number)
    @number = number.to_i
  end

  def commands
    list = []
    list << 'wink'            if match?(0b1)
    list << 'double blink'    if match?(0b10)
    list << 'close your eyes' if match?(0b100)
    list << 'jump'            if match?(0b1000)
    list.reverse!             if match?(0b10000)
    list
  end

  private

  def match?(binary)
    (@number & binary).nonzero?
  end
end

# https://exercism.org/tracks/ruby/exercises/secret-handshake/solutions/copiousfreetime
class SecretHandshakeCopious
  MAPPING = {
    0b00001 => ->(parts) { parts << 'wink' },
    0b00010 => ->(parts) { parts << 'double blink' },
    0b00100 => ->(parts) { parts << 'close your eyes' },
    0b01000 => ->(parts) { parts << 'jump' },
    0b10000 => ->(parts) { parts.reverse! }
  }.freeze

  attr_reader :number

  def initialize(number)
    @number = number.to_i
  end

  def commands
    # interesting approach of constructing array on the fly
    # cmds will dynamically be filled with commands on every action.call(cmds)
    [].tap do |cmds|
      MAPPING.each do |mask, action|
        # Bitwise AND, will return non zero if both bits
        # are 1 at positions in the mask
        action.call(cmds) unless (number & mask).zero?
      end
    end
  end
end
