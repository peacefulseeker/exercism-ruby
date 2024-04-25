class LogLineParser
  def initialize(line)
    @line = line
    @level, @message = @line.split(': ')
  end

  def message
    @message.strip
  end

  def level
    # @level[1..-2].downcase
    @level.gsub(/[\[\]]/, '').downcase
  end

  def log_level
    level
  end

  def reformat
    "#{message} (#{level})"
  end
end
