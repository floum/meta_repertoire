module Repertoire
  attr_reader :lines
  def initialize(color, lines, game_count)
    @color = color
    @lines = parse_lines(lines)
  end

  def answer(fen)
    line = @lines.find{|line| line.moves.map(&:fen) == fen}
    line.moves.find{|move| move.fen == fen} if line
  end

  private

  def parse_lines(lines)
    lines.each do |line|
      moves = line.split(' ')
      game = PGN::Game.new(moves)
      fens = game.fen_list
      _moves = fens.zip(moves).map {|fen, move| Move.new(fen, san)}
      line = Line.new(_moves)

      @lines << line
    end
  end
end
