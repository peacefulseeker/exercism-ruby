class Grep
  def self.grep(*args)
    Grep.new(*args).grep
  end

  def initialize(pattern, flags, files)
    @flags = Flags.new(flags)
    @is_single_flag = flags.size == 1
    @multiple_files = files.size > 1
    @pattern = pattern
    @files = files
  end

  def grep
    files.map.with_object(Set.new) do |file, matched_lines|
      lines_with_number = File.read(file).lines.map.with_index { |line, index| [line.strip, index + 1] }
      lines_with_number.each do |line, number|
        matches_exact_line = line == pattern

        if is_single_flag && flags.full_line_match
          matches = matches_exact_line
        else
          matches = line.match?(/#{pattern}/)
          if flags.case_insensitive
            matches = line.downcase.match?(/#{pattern.downcase}/) || matches
          elsif flags.full_line_match
            matches = matches_exact_line || matches
          end
        end
        will_add_line = (flags.invert && !matches) || (!flags.invert && matches)
        next unless will_add_line

        if flags.file_names_only
          line = file
        else
          line = "#{number}:#{line}" if flags.prepend_line_number
          line = "#{file}:#{line}" if multiple_files
        end
        matched_lines.add(line)
      end
    end.join("\n")
  end

  private

  attr_reader :flags, :is_single_flag, :pattern, :files, :multiple_files
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
