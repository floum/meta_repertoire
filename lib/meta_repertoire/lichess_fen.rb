module MetaRepertoire
  class LichessFEN
    def initialize(fen)
      @fen = fen
      @moves = []
    end

    def meta_move(tendency)
      @moves.sort_by(&:value)
    end
  end
end
