require_relative 'journey'

class Oystercard
  attr_reader :balance, :in_journey, :journey
  LIMIT = 90
  MIN_CHARGE = 1

  def initialize
    @balance = 0
    @journey = Journey.new
  end

  def top_up(money)
    fail "There is a max limit of £#{LIMIT}" if @balance + money > LIMIT
    @balance += money  
  end

  def touch_in(station)
    fail "Insufficient balance" if @balance < MIN_CHARGE
    @journey.start(station)
    @in_journey = true  
  end

  def touch_out(station)
    @journey.finish(station)
    @in_journey = false
    deduct(MIN_CHARGE)
  end
  
  def in_journey?
    !!@journey.entry_station
  end
end

private 

def deduct(money)
  @balance -= money
end  
