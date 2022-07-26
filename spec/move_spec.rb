RSpec.describe Move do
  it 'knows its color' do
    move = Move.new('rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR w KQkq - 0 1', 'd4')
    expect(move.color).to eq 'white'
  end
end
