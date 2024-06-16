class BankAccount
  def initialize
    @state = :closed
    @balance = 0
  end

  def open
    raise ArgumentError, "You can't open an already open account" if opened?

    @state = :open
  end

  def close
    raise ArgumentError, "You can't close an already closed account" if closed?

    @state = :closed
    @balance = 0
  end

  def balance
    raise ArgumentError, "You can't check the balance of a closed account" unless opened?

    @balance
  end

  def deposit(amount)
    raise ArgumentError, "You can't deposit money into a closed account" unless opened?
    raise ArgumentError, "You can't deposit a negative amount" if amount.negative?

    @balance += amount
  end

  def withdraw(amount)
    raise ArgumentError, "You can't withdraw money into a closed account" unless opened?
    raise ArgumentError, "You can't withdraw more than you have" if amount > @balance
    raise ArgumentError, "You can't withdraw a negative amount" if amount.negative?

    @balance -= amount
  end

  private

  def opened?
    @state == :open
  end

  def closed?
    @state == :closed
  end
end
