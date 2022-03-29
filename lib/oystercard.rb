require_relative 'journey'

class Oystercard
  attr_reader :balance
  LIMIT = 90
  MIN_CHARGE = 1

  def initialize
    @balance = 0
    @journey = nil
  end

  def top_up(money)
    fail "There is a max limit of £#{LIMIT}" if @balance + money > LIMIT
    @balance += money  
  end

  def touch_in(station)
    fail "Insufficient balance" if @balance < MIN_CHARGE
    @journey = Journey.new(station)
  end

  def touch_out(station)
    @journey.finish(station)
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
