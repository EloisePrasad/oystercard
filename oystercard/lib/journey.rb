require 'oystercard'
# MINIMUM_FEE = 5
class Journey
  attr_reader :starting_station, :exit_station, :fare

  def start_journey(station)
    @starting_station = station
  end

  def end_journey(station)
    @exit_station = station
  end

  def complete_journey
    {start: @starting_station, end: @exit_station}
  end

  def fare
    return PENALTY_FEE if incomplete_journey?
    MINIMUM_FEE
  end

  def incomplete_journey?
    (!@starting_station.nil? && @exit_station.nil?) || (!@exit_station.nil? && @starting_station.nil?)
  end 
end
