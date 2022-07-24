module MetaRepertoire
  class KnownMove
    attr_reader :count, :san, :resulting_fen
    attr_writer :count
    def initialize(fen, san, count)
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
