require 'Oystercard'

describe Oystercard do

  it "responds to #balance" do
    expect(subject).to respond_to :balance
  end

  it "contains @balance attribute" do
      expect(subject.balance).to eq @balance
  end

end
