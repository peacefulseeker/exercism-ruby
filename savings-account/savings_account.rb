module SavingsAccount
  # 0.5% for a non-negative balance less than 1000 dollars.
  # 1.621% for a positive balance greater than or equal to 1000 dollars and less than 5000 dollars.
  # 2.475% for a positive balance greater than or equal to 5000 dollars.
  # 3.213% for a negative balance (results in negative interest).

  RATTES = {
    0...1000 => 0.5, # float range 0 to 999.9999999999999
    1000...5000 => 1.621, # float range 1000 to 4999.999999999999
    5000... => 2.475, # 5000+
    ...0 => 3.213, # -Infinity to 0
  }

  def self.interest_rate(balance)
    RATTES.select { |range, _| range.cover?(balance) }.values.first
  end

  def self.annual_balance_update(balance)
    balance * interest_rate(balance) / 100 + balance
  end

  def self.years_before_desired_balance(current_balance, desired_balance)
    years = 0
    until current_balance >= desired_balance
      current_balance = annual_balance_update(current_balance)
      years += 1
    end

    years
  end
end
