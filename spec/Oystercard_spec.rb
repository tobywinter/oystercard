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

  it { is_expected.to respond_to(:touch_in) }
  it { is_expected.to respond_to(:touch_out) }
  it { is_expected.to respond_to(:in_journey?) }

  it "Checks if the card is not @in_journey" do
    expect(subject).not_to be_in_journey
  end

  it "has @in_journey instance variable" do
    expect(subject.in_journey).to eq false
  end


end
