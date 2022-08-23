module MetaRepertoire
  class MetaRepertoire < Repertoire
    def initialize(options)
      super
    end

    def pretty_print
      "#{@color}\n" << super
    end

    def initial_moves
      if @color == 'white'
        [@lichess.fetch(STARTING_FEN).meta_move.move]
      else
        []
      end
    end

    def initial_fen
      if @color == 'white'
        initial_moves.first.resulting_fen
      else
        STARTING_FEN
      end
    end

    def answer(move)
      @lichess.fetch(move.resulting_fen).meta_move.move
    end
  end
end
