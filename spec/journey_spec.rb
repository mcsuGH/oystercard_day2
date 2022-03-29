require 'journey'

describe Journey do 
  let(:station) { double :station, zone: 1}

  it "returns itself when exiting a journey" do
    expect(subject.finish(station)).to eq(subject)
  end

  context 'given an entry station' do
    let(:subject) {Journey.new(station)}

    it 'knows if a journey is not complete' do
      expect(subject).not_to be_complete
    end

    it 'has an entry station' do
      expect(subject.entry_station).to eq station
    end

    it 'has a penalty fare if no exit station is given' do
      expect(subject.fare).to eq Journey::PENALTY_FARE
    end

    context 'given an exit station' do
      let(:exit_station) { double :exit_station }
      before do
        subject.finish(exit_station)
      end

      it 'calculates a fare' do
        expect(subject.fare).to eq 1
      end

      it 'knows if a journey is complete' do
        expect(subject).to be_complete
      end
    end
  end

end