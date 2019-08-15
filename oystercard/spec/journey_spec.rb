require 'journey'
# require 'oystercard'
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
  it 'can calculate a fare' do
    expect(subject.fare).to eq(MINIMUM_FEE)
  end
  it 'is not in journey if journey not started' do
    expect(subject).to_not be_incomplete_journey
  end
  it 'can return whether the journey is incomplete' do
    subject.start_journey(starting_station)
    expect(subject).to be_incomplete_journey
  end
  describe 'penalty fare' do
    it 'can charge the penalty fare when theres no touch_in' do
      subject.end_journey(exit_station)
      expect(subject.fare).to eq(PENALTY_FEE)
    end
    it 'can charge the penalty fare when theres no touch_out' do
      subject.start_journey(exit_station)
      expect(subject.fare).to eq(PENALTY_FEE)
    end
  end
end
