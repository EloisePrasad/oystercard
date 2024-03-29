require './lib/oystercard'
describe Oystercard do
  let(:station) { double(:station) }
  let(:exit_station) { double(:exit_station) }
  it 'can have a default balance of 0' do
    expect(subject.balance).to eq(0)
  end
  it 'can respond to top_up' do
    expect(subject).to respond_to(:top_up).with(1).argument
  end
  describe '#top_up' do
    it 'can increase balance' do
      expect(subject.top_up(10)).to eq(10)
    end
    it 'can raise error at limit' do
      maximum_balance = MAXIMUM_BALANCE
      subject.top_up(maximum_balance)
      expect { subject.top_up(1) }.to raise_error("#{maximum_balance} is the limit")
    end
  end
  describe '#deduct' do
    xit 'can deduct balance' do
      subject.top_up(20)
      expect(subject.deduct(10)).to eq(15)
    end
  end
  describe '#in_journey?' do
    xit 'can return if journey is incomplete' do
      # expect(subject.in_journey?).to be(false)
      expect(subject).to_not be_incomplete_journey
    end
    xit 'can return if journey is not incomplete' do
      subject.top_up(10)
      subject.touch_in(station)
      subject.touch_out(station)
      expect(subject).to_not be_incomplete_journey
    end
  end
  describe '#touch_in' do
    it 'can touch in, starting journey' do
      subject.top_up(1)
      subject.touch_in(station)
      expect(subject).to be_incomplete_journey
    end
    it 'can raise an error at lower limit' do
      expect { subject.touch_in(station) }.to raise_error("You need a a minimum of #{MINIMUM_BALANCE}")
    end
    xit 'can record starting station' do
      subject.top_up(10)
      subject.touch_in(station)
      expect(subject.starting_station).to eq(station)
    end
  end
  describe '#touch_out' do
    xit 'can touch out, end journey' do
      subject.top_up(10)
      subject.touch_in(station)
      subject.touch_out(exit_station)
      expect(subject).to_not be_incomplete_journey
    end
    xit 'erases the starting station' do
      subject.top_up(10)
      subject.touch_in(station)
      subject.touch_out(exit_station)
      expect(subject.starting_station).to be_nil
    end
    it 'charges at least the minimum fee' do
      subject.top_up(10)
      subject.touch_in(station)
      # expect(subject.balance).to eq(5)
      expect { subject.touch_out(exit_station) }.to change{ subject.balance }.by(-MINIMUM_FEE)
    end
    xit 'can record exit station' do
      subject.top_up(10)
      subject.touch_in(station)
      subject.touch_out(exit_station)
      expect(subject.exit_station).to eq(exit_station)
    end
  end
  describe '#journey_history' do
    xit 'empty journey_history by default' do
      expect(subject.journey_history).to be_empty
    end
    xit 'it has a start and end journey' do
      subject.top_up(10)
      subject.touch_in(station)
      subject.touch_out(exit_station)
      expect(subject.journey_history).to include({start: station, end: exit_station})
    end
  end
end
