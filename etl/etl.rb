class ETL
  def self.transform(old)
    old.each_with_object({}) do |item, transformed|
      key, letters = item
      letters.each { |letter| transformed[letter.downcase] = key }
    end
  end
end
