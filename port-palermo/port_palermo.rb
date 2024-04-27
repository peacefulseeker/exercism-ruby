module Port
  IDENTIFIER = :PALE
  TERMINAL_A = :A
  TERMINAL_B = :B

  CITY_TO_IDENTIFIER = {
    'Hamburg' => :HAMB,
    'Rome' => :ROME,
    'Kiel' => :KIEL
  }.freeze

  def self.get_identifier(city)
    CITY_TO_IDENTIFIER[city]
  end

  def self.get_terminal(ship_identifier)
    %w[OIL GAS].include?(ship_identifier[..2]) ? TERMINAL_A : TERMINAL_B
  end
end
