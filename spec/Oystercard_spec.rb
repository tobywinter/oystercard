require 'Oystercard'

describe Oystercard do

  it "responds to #balance" do
    expect(subject).to respond_to :balance
  end

  it "contains @balance attribute" do
      expect(subject.balance).to eq 0
  end

  it 'responds to entry_station' do
    expect(subject).to respond_to :entry_station
  end

  it 'responds to journeys' do
    expect(subject).to respond_to :journeys
  end

  context 'recording journey' do
    let (:entry_station) {double(:station)}
    let (:exit_station)  {double(:station)}
    before {subject.top_up(20)}

    it 'has an empty list of journeys by default' do
      expect(subject.journeys).to be_empty
    end

    it 'checks that touching in saves entry station' do
      expect {subject.touch_in(entry_station)}.to change{subject.journeys}.to eq([{entry_station: entry_station}])
    end

    it 'checks that touching out saves exit station' do
      subject.touch_in(entry_station)
      subject.touch_out(exit_station)
      expect(subject.journeys).to eq([{entry_station: entry_station, exit_station: exit_station}])
    end

  end

  describe '#top_up' do

    it "allows user to top up balance" do
      expect(subject).to respond_to :top_up
    end

    it "increases balance by amount given" do
      expect(subject.top_up(5)).to eq 5
    end

    it "raises error 'Exceeds maximum limit' message" do
      expect {subject.top_up(91)}.to raise_error("Exceeds maximum limit: Balance must not exceed £#{Oystercard::MAX_LIMIT}")
    end

  end

    it "@max_limit is set to 90 pounds" do
      expect(subject.max_limit).to eq 90
    end

  describe "#in_journey?" do
    it "Checks if the card is not in journey" do
      expect(subject).not_to be_in_journey
    end
  end

  describe "#below_minimum_balance" do

    it "returns true when below @minimum_balace" do
      expect(subject.below_minimum_balance).to eq true
    end

    it "returns false when above @minimum_balace" do
      oystercard = Oystercard.new(30)
      expect(oystercard.below_minimum_balance).to eq false
    end

  end


  describe "#touch_in" do
    let(:station) {double(:station)}

    it "will raise error 'Insufficient funds' if below minimum balance" do
      expect {subject.touch_in(station)}.to raise_error("Insufficient funds: Minimum balance - £#{Oystercard::MINIMUM_BALANCE}")
    end

    it "will save station in @entry_station" do
      subject.top_up(20)
      expect {subject.touch_in(station)}.to change{subject.entry_station}.to eq(station)
    end

  end

  describe "#touch_out" do
    let(:fare) {fare = 1}
    let(:exit_station) {double(:station)}
    let(:entry_station) {double(:station)}
    before {subject.top_up(20)}


    it 'deducts fare from balance upon touch out' do
      subject.touch_in(entry_station)
      expect {subject.touch_out(fare,exit_station)}.to change{subject.balance}.by(-fare)
    end

  end



end
