module MetaRepertoire
  class Move
    attr_reader :san, :resulting_fen, :fen
    def initialize(fen, san)
      @fen = fen
      @san = san
      @resulting_fen = PGN::FEN.new(@fen).to_position.move(@san).to_fen.to_s
    end

    def inspect
      "#{@san}"
    end

    def to_s
      "#{@san}"
    end


    def ==(other)
      other.fen == fen && other.san == san
    end

    def color
      @fen.split(' ')[1] == 'w' ? 'white' : 'black'
    end
  end

  class NullMove < Move
    def initialize(fen)
      @fen = fen 
    end

    def inspect
      "#{@fen} | NullMove"
    end
  end
end
