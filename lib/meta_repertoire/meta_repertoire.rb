module MetaRepertoire
  class MetaRepertoire < Repertoire
    def initialize(options)
      super
      @lichess = Lichess.new(options)
    end

    def pretty_print
      "#{@color}\n" << super
    end

    def initial_fen
      return STARTING_FEN if @color == 'black'
      @lichess.fetch(STARTING_FEN).meta_move.resulting_fen
    end

    def meta_move(fen)
      @lichess.meta_move(fen)
    end
  end
end
