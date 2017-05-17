require 'station'

describe Station do
  subject(:station) { described_class.new('Bank', 1) }

  it 'has name on creation' do
    expect(station.name).to eq('Bank')
  end

  it 'has zone on creation' do
    expect(station.zone).to eq(1)
  end
end
