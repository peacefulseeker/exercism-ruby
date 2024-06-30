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
