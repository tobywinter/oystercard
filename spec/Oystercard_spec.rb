require 'Oystercard'

describe Oystercard do

  it "responds to #balance" do
    expect(subject).to respond_to :balance
  end

  it "contains @balance attribute" do
      expect(subject.balance).to eq 0
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

  describe "#deduct_fare" do
    it "will deduct fare from balance" do
      oystercard = Oystercard.new(35)
      expect(oystercard.deduct_fare(30)).to eq 5
    end

  end

  it "Checks if the card is not @in_journey" do
    expect(subject).not_to be_in_journey
  end

  it "has @in_journey instance variable" do
    expect(subject.in_journey).to eq false
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

    it "will change in_journey to true" do
      oystercard = Oystercard.new(30)
      expect(oystercard.touch_in).to eq true
    end

    it "will raise error 'Insufficient funds' if below minimum balance" do
      expect {subject.touch_in}.to raise_error("Insufficient funds: Minimum balance - £#{Oystercard::MINIMUM_BALANCE}")
    end

  end

  describe "#touch_out" do
    let(:fare) {fare = 1}

    it "will change in_journey to false" do
      expect(subject.touch_out(fare)).to eq false
    end

    it 'deducts fare from balance upon touch out' do
      expect {subject.touch_out(fare)}.to change{subject.balance}.by(-fare)
    end
  end

end
