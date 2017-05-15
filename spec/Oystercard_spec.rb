require 'Oystercard'


describe Oystercard do

  describe '#initialize' do

    it "has @money attribute/instance variable" do
      expect(subject.money).to eq @money
    end

  end

end
