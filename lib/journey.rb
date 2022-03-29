class Journey
  attr_accessor :entry_station, :exit_station
  attr_reader :journeys

  def initialize
    @entry_station = nil
    @exit_station = nil
    @journeys = []
  end

  def record_journey(station)  
    @exit_station = station
    @journeys << {entry_station: @entry_station, exit_station: station}
    @entry_station = nil
  end
end