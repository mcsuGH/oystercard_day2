class Journey
  attr_accessor :entry_station, :exit_station

  PENALTY_FARE = 6

  def initialize(entry_station = nil)
    @exit_station = nil
    @entry_station = entry_station
  end

  def finish(station)  
    @exit_station = station
    @entry_station = nil
    self
  end

  def complete?
    @entry_station == nil ? true : false
  end

  def fare
    if complete?
      1
    else
      PENALTY_FARE
    end
  end
end