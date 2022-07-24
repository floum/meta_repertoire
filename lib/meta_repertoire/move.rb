module MetaRepertoire
  class Move
    attr_reader :san, :resulting_fen, :fen
    def initialize(fen, san)
      @fen = fen
      @san = san
      @resulting_fen = PGN::FEN.new(@fen).to_position.move(@san).to_fen
    end

    def inspect
      "#{@fen} - #{@san}"
    end

    def ==(other)
      other.fen == fen && other.san == san
    end
  end
end
