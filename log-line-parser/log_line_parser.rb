class LogLineParser
  def initialize(line)
    @line = line
    @level, @message = @line.split(': ')
  end

  def message
    @message.strip
  end

  def log_level
     # @level[1..-2].downcase
     @level.gsub(/[\[\]]/, '').downcase
  end

  def reformat
    "#{message} (#{log_level})"
  end
end
