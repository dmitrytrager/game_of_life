require './app/cell'

describe Cell do
  let(:cell) { Cell.new(live, 0, 0) }

  describe '#live?' do
    subject { cell.live? }

    context 'when cell is live by value' do
      let(:live) { true }

      it "returns true" do
        expect(subject).to be_truthy
      end
    end

    context 'when cell is dead by value' do
      let(:live) { false }

      it "returns false" do
        expect(subject).to be_falsey
      end
    end
  end

  describe '#to_i' do
    subject { cell.to_i }

    context 'when cell is live by value' do
      let(:live) { true }

      it "returns 1" do
        expect(subject).to eq(1)
      end
    end

    context 'when cell is dead by value' do
      let(:live) { false }

      it "returns 0" do
        expect(subject).to eq(0)
      end
    end
  end
end
