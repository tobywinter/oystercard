class Oystercard

  attr_reader :balance, :max_limit, :in_journey, :entry_station, :journeys

  MAX_LIMIT = 90
  DEFAULT_BALANCE = 0
  MINIMUM_BALANCE = 1
  MIN_FARE = 1

  def initialize(balance = DEFAULT_BALANCE)
    @balance = balance
    @max_limit = MAX_LIMIT
    @entry_station = nil
    @journeys = []
  end

  def top_up(amount)
    raise "Exceeds maximum limit: Balance must not exceed £#{@max_limit}" if exceeds_max_limit?(amount)
    @balance += amount
  end

  def touch_in(station)
    raise "Insufficient funds: Minimum balance - £#{MINIMUM_BALANCE}" if below_minimum_balance
    @journeys << {entry_station: station}
    @entry_station = station
  end

  def touch_out(fare = MIN_FARE, exit_station)
    deduct_fare(fare)
    @journeys.last[:exit_station] = exit_station
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
