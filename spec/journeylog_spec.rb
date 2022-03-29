require 'journeylog'

describe JourneyLog do
  let(:journey) { double :journey, new: station } 
  let(:station) { double :station }
  let(:journey_class) { double :journey_class, new: journey }
  let(:subject) { JourneyLog.new(journey_class) }

  describe '#start' do
    it 'starts a journey' do
      expect(journey_class).to receive(:new).with(entry_station: station)
      subject.start(station)
    end

    it 'records a journey' do
      allow(journey_class).to receive(:new).and_return journey
      subject.start(station)
      expect(subject.journeys).to include(journey)
    end
  end
end





#Write up a plan for how you will interact with your code and manually test in IRB.
#test drive the development of JourneyLog class
#start should start a new journey with an entry station
#Initialise the JourneyLog with a journey_class parameter (hint: journey_class expects an object that knows how to create Journeys. Can you think of an object that already does this?)
#a private method #current_journey should return an incomplete journey or create a new journey
#finish should add an exit station to the current_journey
#journeys should return a list of all previous journeys without exposing the internal array to external modification
#remove redundant code from OysterCard class