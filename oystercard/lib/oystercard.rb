MAXIMUM_BALANCE = 90
MINIMUM_BALANCE = 1
MINIMUM_FEE = 5

class Oystercard

  attr_reader :balance, :journey_history, :journey

  def initialize
    # @starting_station = nil
    @balance = 0
    @journey_history = []
    # @in_journey = false
  end
  def top_up(num)
    fail "#{MAXIMUM_BALANCE} is the limit" if maximum?(num)
    @balance += num
  end
  def in_journey?
    @journey.nil? ? false : true
    # !@starting_station.nil?
    # @in_journey
  end
  def touch_in(station)
    fail "You need a a minimum of #{MINIMUM_BALANCE}" if @balance < MINIMUM_BALANCE
    @journey = Journey.new
    @journey.start_journey(station)
    # @in_journey = true
  end
  def touch_out(station)
    @journey.end_journey(station)
    store_journey_history
    deduct(MINIMUM_FEE)
    @journey = nil
  end
  def store_journey_history
    @journey_history.push(@journey.complete_journey)
  end
  private
  def maximum?(num)
    @balance + num > MAXIMUM_BALANCE
  end
  def deduct(num)
    @balance -= num
  end
end
