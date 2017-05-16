require 'station'

describe Station do
  subject(:station) { described_class.new }

  it 'has name on creation' do
    expect(station).to respond_to :name
  end

  it 'has zone on creation' do
    expect(station).to respond_to :zone
  end
end
