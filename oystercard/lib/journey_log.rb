class JourneyLog
  attr_reader :log
  def initialize(journey_class = Journey)
    @journey_class = journey_class
    @log = []
  end
  def start(station)
    @current_journey = @journey_class.new
    @current_journey.start_journey(station)
  end
  def finish(station)
    @current_journey.end_journey(station)
    @log.push(@current_journey)
    @current_journey = nil
  end
  def fare
    @log.last.fare
  end
  def incomplete_journey?
    @current_journey.incomplete_journey?
  end
end
