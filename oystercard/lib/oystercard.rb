MAXIMUM_BALANCE = 90
MINIMUM_BALANCE = 1
MINIMUM_FEE = 5
PENALTY_FEE = 6
class Oystercard

  attr_reader :balance, :journey_history, :journey

  def initialize(journeylog_class = JourneyLog)
    # @starting_station = nil
    @balance = 0
    @journey_log = journeylog_class.new
    # @in_journey = false
  end
  def top_up(num)
    fail "#{MAXIMUM_BALANCE} is the limit" if maximum?(num)
    @balance += num
  end
  def incomplete_journey?
    @journey_log.incomplete_journey?
    # !@starting_station.nil?
    # @in_journey
  end
  def touch_in(station)
    fail "You need a a minimum of #{MINIMUM_BALANCE}" if @balance < MINIMUM_BALANCE
    @journey_log.start(station)
    # @in_journey = true
  end
  def touch_out(station)
    @journey_log.finish(station)
    deduct(@journey_log.fare)
  end

  private
  def maximum?(num)
    @balance + num > MAXIMUM_BALANCE
  end
  def deduct(num)
    @balance -= num
  end
end
