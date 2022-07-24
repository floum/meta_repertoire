module MetaRepertoire
  class Move
    attr_reader :san, :resulting_fen
    def initialize(fen, san)
      @count = count
      @fen = fen
      @san = san
      @resulting_fen = PGN::FEN.new(@fen).to_position.move(@san).to_fen
    end

    def inspect
      "#{@san}"
    end
  end
end
