class Oystercard

  attr_reader :balance, :max_limit

  MAX_LIMIT = 90
  DEFAULT_BALANCE = 0

  def initialize(balance = DEFAULT_BALANCE)
    @balance = balance
    @max_limit = MAX_LIMIT
  end

  def top_up(amount)
    @balance += amount
  end

  def max_limit?
    @max_limit
  end

end
