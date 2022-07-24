module MetaRepertoire
  class Line
    attr_reader :moves

    def initialize(moves)
      @moves = moves
    end

    def first(n)
      Line.new(@moves.first(n))
    end

    def +(move)
      Line.new(@moves << move)
    end

    def lichess_responses
      lichess_data.responses
    end

    def lichess_size
      lichess_data.size
    end

    def subline_sizes(count)
      lsc = LineSizeCalculator(final_fen, count)
    end

    def fen
      @moves.last.resulting_fen
    end

    private

    def lichess_data
      @lichess_data ||= LichessFENData.new(fen)
    end

  end
end
