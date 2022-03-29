class Oystercard
  attr_reader :balance, :journeys, :entry_station, :exit_station
  Limit = 90
  Min_charge = 1

  def initialize
    @balance = 0
    @entry_station = nil
    @exit_station = nil
    @journeys = []
  end

  def top_up(money)
    fail "There is a max limit of £#{Limit}" if @balance + money > Limit
    @balance += money  
  end

  def touch_in(station)
    fail "Insufficient balance" if @balance < Min_charge
    @entry_station = station
    @exit_station = nil
    @in_journey = true  
  end

  def touch_out(station)
    record_journey(station)
    deduct(Min_charge)
  end
  
  def in_journey?
    !!entry_station
  end
end

private 

def deduct(money)
  @balance -= money
end  

def record_journey(station)  
  @exit_station = station
  @journeys << {entry_station: @entry_station, exit_station: station}
  @entry_station = nil
  @in_journey = false
end