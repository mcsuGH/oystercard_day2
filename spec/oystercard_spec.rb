require 'oystercard'

describe Oystercard do
  let(:entry_station) { double :station }
  let(:exit_station) { double :station }
  let(:journey){ {entry_station: entry_station, exit_station: exit_station} }

  context 'Card with no balance' do
    it 'A new card should have a default balance of 0' do
      expect(subject.balance).to eq 0
    end

    it 'Check for minimum balance' do
      expect { subject.touch_in(entry_station) }.to raise_error "Insufficient balance"
    end
  end

  context 'Card can make a journey and' do
    before do
      subject.top_up(1)
    end

    it 'remembers the entry station' do
      subject.touch_in(entry_station)
      expect(subject.journey.entry_station).to eq entry_station 
    end  

    it 'stores exit station' do 
      subject.touch_in(entry_station)
      subject.touch_out(exit_station)
      expect(subject.journey.exit_station).to eq exit_station
    end

    it 'has a empty list of journeys by default' do
      expect(subject.journey.journeys).to be_empty
    end

    it 'stores the journey' do
      subject.touch_in(entry_station)
      subject.touch_out(exit_station)
      expect(subject.journey.journeys).to include journey 
    end
  end


  describe '#top_up' do
    it { is_expected.to respond_to(:top_up).with(1).argument }

    it 'top up the card' do
      expect{ subject.top_up 50 }.to change{ subject.balance }.by 50
    end

    it 'Raises an error if the maximum balance is exceeded' do
      expect { subject.top_up(1 + Oystercard::Limit) }.to raise_error "There is a max limit of £90"
    end
  end

  describe '#touch_in' do
    it 'Should be able to touch in' do
      subject.top_up(1)
      subject.touch_in(entry_station)
      expect(subject.in_journey?).to eq true
    end
  end

  describe '#touch_out' do
    before do
      subject.top_up(1)
      subject.touch_in(entry_station)
    end
  
    it 'Should be able to touch out' do
      subject.touch_out(exit_station)
      expect(subject.in_journey?).to eq false
    end

    it 'Should take a minimum fare when touching out' do
      expect{ subject.touch_out(exit_station) }.to change{ subject.balance }.by -1
    end
  end

  describe '#in_journey?' do
    it { is_expected.to respond_to (:in_journey?) }

    it 'is initially not in a journey' do
      expect(subject).not_to be_in_journey
    end
  end
end
