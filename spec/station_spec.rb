require 'station'

describe Station do
  subject {described_class.new("Old Street", 1)}

  it "Knows it's name" do
    expect(subject.name).to eq("Old Street")
  end

  it 'Should know what zone it is in' do
    expect(subject.zone).to eq(1)
  end
end