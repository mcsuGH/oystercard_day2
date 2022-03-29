class JourneyLog
  attr_reader :current_journey

  def initialize(journey_class: )
    @journey_class = journey_class
    @journeys = []
    @current_journey = {entry_station: nil , exit_station: nil}
  end

  def start(station)
    @current_journey[:entry_station] = station
    @journey_class.new(station)
  end

  def destination(station)
    @current_journey[:exit_station] = station
    @journeys << @current_journey
    @current_journey = {entry_station: nil , exit_station: nil}
    @journey_class.finish(station)
  end

  def journeys
    @journeys.dup
  end

  private
  def current
    @current_journey ||= journey_class.new
  end

end


