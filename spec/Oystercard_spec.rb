require 'oystercard'

describe Oystercard do
  let (:entry_station) { double(:station) }
  let (:exit_station)  { double(:station) }

  subject(:card) { described_class.new }
  subject(:empty_card) { described_class.new }
  before { card.top_up(20) }

  describe 'responsiveness' do
    it 'responds to #balance' do
      expect(card).to respond_to :balance
    end

    it 'contains @balance attribute' do
      expect(card.balance).to eq 20
    end

    it 'responds to entry_station' do
      expect(card).to respond_to :entry_station
    end

    it 'responds to journeys' do
      expect(card).to respond_to :journeys
    end
  end

  context 'recording journey' do
    it 'has an empty list of journeys by default' do
      expect(card.journeys).to be_empty
    end

    it 'checks that touching in saves entry station' do
      expect { card.touch_in(entry_station) }.to change { card.journeys }.to eq([{ entry_station: entry_station }])
    end

    it 'checks that touching out saves exit station' do
      card.touch_in(entry_station)
      card.touch_out(exit_station)
      expect(card.journeys).to eq([{ entry_station: entry_station, exit_station: exit_station }])
    end
  end

  describe '#top_up' do
    it 'allows user to top up balance' do
      expect(card).to respond_to :top_up
    end

    it 'increases balance by amount given' do
      expect(card.top_up(5)).to eq 25
    end

    it "raises error 'Exceeds maximum limit' message" do
      exceeds_limit_message = "Exceeds maximum limit: £#{Oystercard::MAX_LIMIT}"
      expect { card.top_up(71) }.to raise_error(exceeds_limit_message)
    end
  end

  it '@max_limit is set to 90 pounds' do
    expect(card.max_limit).to eq 90
  end

  describe '#in_journey?' do
    it 'Checks if the card is not in journey' do
      expect(card).not_to be_in_journey
    end
  end

  describe '#below_minimum_balance' do
    it 'returns true when below @minimum_balace' do
      expect(empty_card.below_minimum_balance).to eq true
    end

    it 'returns false when above @minimum_balace' do
      expect(card.below_minimum_balance).to eq false
    end
  end


  describe '#touch_in' do
    it "will raise error 'Insufficient funds' if below minimum balance" do
      top_up_message = "Insufficient funds: Minimum balance - £#{Oystercard::MINIMUM_BALANCE}"
      expect { empty_card.touch_in(entry_station) }.to raise_error(top_up_message)
    end

    it 'will save station in @entry_station' do
      expect { card.touch_in(entry_station) }.to change { card.entry_station }.to eq(entry_station)
    end
  end

  describe '#touch_out' do
    it 'deducts fare from balance upon touch out' do
      card.touch_in(entry_station)
      expect { card.touch_out(exit_station) }.to change { card.balance }.by(-Oystercard::MIN_FARE)
    end
  end
end
