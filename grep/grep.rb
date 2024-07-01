class Grep
  def initialize(pattern, flags, files)
    @flags = Flags.new(flags)
    @single_flag = flags.size == 1
    @single_file = files.one?
    @pattern = pattern
    @files = files
  end

  def self.grep(*args)
    Grep.new(*args).grep
  end

  def grep
    files.map.with_object(Set.new) do |file, matched_lines|
      File.read(file).lines.map(&:rstrip).each_with_index do |line, index|
        matches = line_matches(line)

        next unless (matches && !flags.invert) || (flags.invert && !matches)
        break matched_lines << file if flags.file_names_only

        matched_lines << [
          ("#{file}:" unless single_file),
          ("#{index.succ}:" if flags.prepend_line_number),
          line
        ].join
      end
    end.join("\n")
  end

  private

  def line_matches(line)
    if single_flag && flags.full_line_match
      matches = line == pattern
    else
      matches = line.match?(/#{pattern}/)
      if flags.case_insensitive
        matches = line.downcase.match?(/#{pattern.downcase}/) || matches
      elsif flags.full_line_match
        matches = line == pattern || matches
      end
    end

    matches
  end

  attr_reader :flags, :single_flag, :pattern, :files, :single_file
end

class Flags
  def initialize(flags)
    @prepend_line_number = flags.include?('-n')
    @case_insensitive = flags.include?('-i')
    @full_line_match = flags.include?('-x')
    @file_names_only = flags.include?('-l')
    @invert = flags.include?('-v')
  end

  attr_reader :prepend_line_number, :case_insensitive, :full_line_match, :file_names_only, :invert
end
