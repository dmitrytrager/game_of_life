require './app/game'

describe Game do
  let(:game) { Game.start_with_data(data) }

  describe '#result' do
    let(:data) { File.open("./seeds/test.txt", "r") { |file| file.read } }

    it "returns inputted data without iterations" do
      expect(game.result).to eq(
<<-EOF
```
1 0 0
0 1 0
1 0 1
```
EOF
      )
    end

    it "returns correct data after iterations" do
      expect(game.iterate(1).result).to eq(
<<-EOF
```
0 0 0
1 1 0
0 1 0
```
EOF
      )
    end
  end
end
