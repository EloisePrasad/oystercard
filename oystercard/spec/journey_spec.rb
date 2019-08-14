require 'journey'
describe Journey do
  let(:starting_station) { double(:starting_station) }
  let(:exit_station) { double(:exit_station) }
  it 'has a starting_station we can check' do
    subject.start_journey(starting_station)
    expect(subject.starting_station).to eq(starting_station)
  end
  it 'has a exit_station we can check' do
    subject.end_journey(exit_station)
    expect(subject.exit_station).to eq(exit_station)
  end
end
