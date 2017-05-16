class Oystercard

  attr_reader :balance, :max_limit, :in_journey, :entry_station

  MAX_LIMIT = 90
  DEFAULT_BALANCE = 0
  MINIMUM_BALANCE = 1

  def initialize(balance = DEFAULT_BALANCE)
    @balance = balance
    @max_limit = MAX_LIMIT
    @entry_station = nil
  end

  def top_up(amount)
    raise "Exceeds maximum limit: Balance must not exceed £#{@max_limit}" if exceeds_max_limit?(amount)
    @balance += amount
  end

  def touch_in(station)
    raise "Insufficient funds: Minimum balance - £#{MINIMUM_BALANCE}" if below_minimum_balance
    @entry_station = station
  end

  def touch_out(fare)
    deduct_fare(fare)
    @entry_station = nil
  end

  def in_journey?
    true if @entry_station
  end

  def below_minimum_balance
    MINIMUM_BALANCE > @balance
  end

private

  def exceeds_max_limit?(amount)
     @max_limit <= (@balance + amount)
  end

  def deduct_fare(amount)
    @balance -= amount
  end

end
