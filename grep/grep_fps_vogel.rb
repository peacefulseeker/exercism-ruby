class Grep
  attr_reader :flags, :files

  def initialize(pattern, flags, files)
    @pattern = pattern
    @flags = flags
    @files = files
  end

  def self.grep(pattern, flags, files)
    new(pattern, flags, files).grep
  end

  def grep
    files.each_with_object([]) do |file, acc|
      File.readlines(file).each.with_index(1) do |line, i|
        if match?(line)
          result = line.chop
          result = "#{i}:" + result if line_numbers?
          result = "#{file}:" + result if multiple_files?
          result = file if filenames?

          acc << result
        end
      end
    end.uniq.join("\n")
  end

  private

  def pattern
    match_line? ? "^#{@pattern}$" : @pattern
  end

  def expression
    case_insensitive? ? /#{pattern}/i : /#{pattern}/
  end

  def match?(line)
    inverted_match? ? line !~ expression : line =~ expression
  end

  def case_insensitive?
    flags.include?('-i')
  end

  def match_line?
    flags.include?('-x')
  end

  def inverted_match?
    flags.include?('-v')
  end

  def line_numbers?
    flags.include?('-n')
  end

  def multiple_files?
    files.size > 1
  end

  def filenames?
    flags.include?('-l')
  end
end
