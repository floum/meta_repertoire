module MetaRepertoire
  class Repertoire
    attr_reader :lines
    def initialize(color, lines, size)
      @color = color
      @lines = []
      @size = size
      parse_lines(lines)
    end

    def answer(fen)
      line = @lines.find{|line| line.moves.map(&:fen).include?(fen)}
      line.moves.find{|move| move.fen == fen} if line
    end

    def own_moves
      @lines.map(&:moves).select{|move| move.color == @color}
    end

    def starting_line
      if @color == 'white'
        @lines.first.first(1)
      else
        Line.new([])
      end
    end

    def subtrees
      SubtreeCalculator.new(starting_line, @size).compute.map do |subtree|
        if answer(subtree.line.fen)
          Subtree.new(subtree.line + answer(subtree.line.fen), subtree.size)
        else
          NullSubtree.new(subtree.line)
        end
      end
    end

    private

    def parse_lines(lines)
      lines.each do |line|
        moves = line.split(' ')
        game = PGN::Game.new(moves)
        fens = game.fen_list
        _moves = fens[0..-2].zip(moves).map {|fen, move| Move.new(fen, move)}
        line = Line.new(_moves)
        @lines << line
      end
    end
  end
end
