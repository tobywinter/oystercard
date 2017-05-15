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
      expect {subject.top_up(91)}.to raise_error("Exceeds maximum limit: Balance must not exceed £#{@max_limit}")
    end

  end

    it "@max_limit is set to 90 pounds" do
      expect(subject.max_limit).to eq 90
    end



end
