module MetaRepertoire
  class MetaRepertoire < Repertoire
    def initialize(options)
      super
      @tendency = options.fetch('tendency') { 'win' }
    end

    def pretty_print
      "#{@color}\n" << super
    end

    def initial_fen
      meta_move(STARTING_FEN).resulting_fen
    end

    def meta_move(fen)
      @lichess_db.meta_move(fen)
    end
  end
end
