require './app/grid'

describe Grid do
  let(:cell) { Cell.new(true, 0, 0) }

  describe '#to_s' do
    let(:grid) { Grid.new([[cell]]) }

    it "prints out data about cells" do
      expect(grid.to_s).to eq(
<<-EOF
```
1
```
EOF
      )
    end
  end

  describe "#evolve" do
    let(:cells) {
      [
        [
          Cell.new(true, 0, 0),
          Cell.new(true, 1, 0)
        ],
        [
          Cell.new(true, 0, 1),
          Cell.new(false, 1, 1)
        ]
      ]
    }
    let(:grid) { Grid.new(cells) }

    it "creates new object of self class while evolving" do
      expect(grid.class).to receive(:new)
      grid.evolve
    end
  end
end
