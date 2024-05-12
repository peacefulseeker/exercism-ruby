class ETL
  def self.transform(old)
    old.each_with_object({}) do |(key, letters), transformed|
      letters.each { |letter| transformed[letter.downcase] = key }
    end
  end
end
