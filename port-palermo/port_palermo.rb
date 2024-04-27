module Port
  IDENTIFIER = :PALE
  TERMINAL_A = :A
  TERMINAL_B = :B

  def self.get_identifier(city)
    city[..3].upcase.to_sym
  end

  def self.get_terminal(ship_identifier)
    %w[OIL GAS].include?(ship_identifier[..2]) ? TERMINAL_A : TERMINAL_B
  end
end
