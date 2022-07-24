RSpec.describe Repertoire do
  subject { Repertoire.new('white', ['d4 Nf6 c4', 'd4 d5 c4'], 20) }
  let(:starting_fen) { 'rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR w KQkq - 0 1' }
  let(:modern_defense) { 'rnbqkb1r/pppppppp/5n2/8/3P4/8/PPP1PPPP/RNBQKBNR w KQkq - 1 2' }
  let(:classical_defense) { 'rnbqkbnr/ppp1pppp/8/3p4/3P4/8/PPP1PPPP/RNBQKBNR w KQkq d6 0 2' }

  it 'has an answer for fens' do
    expect(subject.answer(starting_fen)).to eq Move.new(starting_fen, 'd4')
    expect(subject.answer(modern_defense)).to eq Move.new(modern_defense, 'c4')
    expect(subject.answer(classical_defense)).to eq Move.new(classical_defense, 'c4')
  end

  it 'manages the game count for a fen' do
    expect(subject.game_count(starting_fen, 20).map{|k,v| v}.reduce(:+)).to eq 20
  end
end
