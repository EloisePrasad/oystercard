require 'journey_log'
describe JourneyLog do
  let(:journey_class) { double(:journey_class, new: journey) }
  let(:journey) { double(:journey) }
  let(:station) { double(:station) }
  describe '#start' do
    it 'is responsible for starting a journey' do
      allow(journey).to receive(:start_journey)
      journeylog = JourneyLog.new(journey_class)
      expect(journey_class).to receive(:new)
      journeylog.start(station)
    end
  end
  describe '#end ' do
    it 'is responsible for ending a journey' do
      allow(journey).to receive(:start_journey)
      allow(journey).to receive(:end_journey)
      journeylog = JourneyLog.new(journey_class)
      journeylog.start(station)
      journeylog.finish(station)
      expect(journeylog.log).to include(journey)
    end
  end
  # describe '#log' do
  #   it 'returns dup of array' do
  #     allow(journey).to receive(:start_journey)
  #     allow(journey).to receive(:end_journey)
  #     journeylog = JourneyLog.new(journey_class)
  #     journeylog.start(station)
  #     journeylog.finish(station)
  #     expect(journeylog.log).to eq([journey])
  #   end
  # end
end
