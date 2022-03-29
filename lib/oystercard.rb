class Oystercard
  attr_reader :balance
  attr_reader :entry_station
  Limit = 90
  Min_charge = 1

  def initialize
    @balance = 0
    @entry_station = nil
  end

  def top_up(money)
    fail "There is a max limit of £#{Limit}" if @balance + money > Limit
    @balance += money  
  end

  def touch_in(station)
    fail "Insufficient balance" if @balance < Min_charge
    @entry_station = station
    @in_journey = true  
  end

  def touch_out
    deduct(Min_charge)
    @in_journey = false
    @entry_station = nil
  end
  
  def in_journey?
    !!entry_station
  end
end

private 

def deduct(money)
  @balance -= money
end  