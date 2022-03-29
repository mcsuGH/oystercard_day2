require_relative 'journeylog'
require_relative 'journey'

class Oystercard
  attr_reader :balance, :journey, :journeylog
  LIMIT = 90
  MIN_CHARGE = 1

  def initialize
    @balance = 0
    @journey = nil
    @journeylog = JourneyLog.new(journey_class: Journey.new)
  end

  def top_up(money)
    fail "There is a max limit of £#{LIMIT}" if @balance + money > LIMIT
    @balance += money  
  end

  def touch_in(station)
    fail "Insufficient balance" if @balance < MIN_CHARGE
    @journey = Journey.new(station)
    @journeylog.start(station)
  end

  def touch_out(station)
    @journeylog.destination(station)
    @journey = nil
    deduct(MIN_CHARGE)
  end
  
  def in_journey?
    @journey.nil? ? false : true
  end
end

private 

def deduct(money)
  @balance -= money
end  
