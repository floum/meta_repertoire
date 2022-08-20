module MetaRepertoire
  class Repertoire
    STARTING_FEN = 'rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR w KQkq - 0 1'

    attr_reader :lines, :answers, :lichess_db

    def initialize(options)
      @color = options.fetch('color') { 'white' }
      @lines = []
      @size = options.fetch('size') { 50 }
      lichess_config = LichessConfig.new(options)
      @lichess_db = LichessDB.new(lichess_config.db, lichess_config.endpoint)
      @answers = {}
      parse_answers(options.fetch('lines') { [] })
    end

    def pretty_print
      @lines.map(&:pretty_print).join("\n")
    end

    def initial_fen
      if @color == 'white'
        @answers[STARTING_FEN].resulting_fen
      else
        STARTING_FEN
      end
    end

    def initial_moves
      if @color == 'white'
        [@answers[STARTING_FEN]]
      else
        []
      end
    end

    def answer(move)
      @answers[move.resulting_fen]
    end

    def compute_lines
      line_sizes = LineSizeCalculator.new(initial_fen, @size, @lichess_db).compute
      line_sizes.each do |move, size|
        if answer(move)
          @lines << Line.new(initial_moves << move << answer(move), size, self)
        else
          @lines << NullLine.new(initial_moves << move, size, self)
        end
      end
    end

    private

    def parse_answers(known_lines)
      known_lines.each do |line|
        moves = line.split(' ')
        game = PGN::Game.new(moves)
        fens = game.fen_list.map(&:to_s)[0..-2].zip(moves).each do |fen, move|
          _move = Move.new(fen, move)
          @answers[fen]= _move if _move.color == @color
        end
      end
    end
  end
end
