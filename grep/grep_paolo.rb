# https://exercism.org/tracks/ruby/exercises/grep/solutions/paolobrasolin

module Grep
  def self.grep(pattern, flags, files)
    [].tap do |results|
      files.each do |file|
        File.read(file).lines.each_with_index do |line, index|
          matcher = Regexp.new(
            flags.include?('-x') ? "^#{pattern}$" : pattern,
            (Regexp::IGNORECASE if flags.include?('-i'))
          )
          next unless line.match?(matcher) ^ flags.include?('-v')
          break results << file if flags.include?('-l')

          results << [
            ("#{file}:" unless files.one?),
            ("#{index.succ}:" if flags.include?('-n')),
            line.rstrip
          ].join
        end
      end
    end.join("\n")
  end
end
