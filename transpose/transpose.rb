class Transpose
  def self.transpose(input)
    return '' if input.empty?

    res = []
    rows = input.split("\n")

    cols = rows.max_by(&:length).length
    cols.times do |index|
      # get the transposed chars from each row
      transposed = rows.map do |row|
        row[index]
      end

      # get rid of "last" nil values in array
      transposed = transposed.select.with_index do |item, item_index|
        item or '' unless item.nil? && transposed[item_index + 1..].all?(&:nil?)
      end

      # add spaces for "nil" items between normal chars
      transposed = transposed.map { |item| item.nil? ? ' ' : item }.join

      res.push(transposed)
    end

    res.join("\n")
  end
end
