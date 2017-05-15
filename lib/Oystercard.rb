class Oystercard

  attr_reader :balance, :max_limit

  MAX_LIMIT = 90
  DEFAULT_BALANCE = 0

  def initialize(balance = DEFAULT_BALANCE)
    @balance = balance
    @max_limit = MAX_LIMIT
  end

  def top_up(amount)
    raise "Exceeds maximum limit: Balance must not exceed £#{@max_limit}" if exceeds_max_limit?(amount)
    @balance += amount
  end

  def deduct_fare(amount)
    @balance -= amount
  end

private

  def exceeds_max_limit?(amount)
     @max_limit <= (@balance + amount)
  end


end
