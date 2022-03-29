require_relative 'journeylog'
require_relative 'journey'

class Oystercard
  attr_reader :balance, :journeylog
  LIMIT = 90
  MIN_CHARGE = 1

  def initialize
    @balance = 0
    @journeylog = JourneyLog.new(journey_class: Journey.new)
  end

  def top_up(money)
    fail "There is a max limit of £#{LIMIT}" if @balance + money > LIMIT
    @balance += money  
  end

  def touch_in(station)
    fail "Insufficient balance" if @balance < MIN_CHARGE
    @journeylog.start(station)
  end

  def touch_out(station)
    @journeylog.destination(station)
    deduct(MIN_CHARGE)
  end
  
  def in_journey?
    @journeylog.current_journey[:entry_station].nil? ? false : true
  end
end

private 

def deduct(money)
  @balance -= money
end  
