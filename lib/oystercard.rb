require_relative 'journey'

class Oystercard
  attr_reader :balance, :in_journey, :journey
  Limit = 90
  Min_charge = 1

  def initialize
    @balance = 0
    @journey = Journey.new
  end

  def top_up(money)
    fail "There is a max limit of £#{Limit}" if @balance + money > Limit
    @balance += money  
  end

  def touch_in(station)
    fail "Insufficient balance" if @balance < Min_charge
    @journey.entry_station = station
    @journey.exit_station = nil
    @in_journey = true  
  end

  def touch_out(station)
    @journey.record_journey(station)
    @in_journey = false
    deduct(Min_charge)
  end
  
  def in_journey?
    !!@journey.entry_station
  end
end

private 

def deduct(money)
  @balance -= money
end  
