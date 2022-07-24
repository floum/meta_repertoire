module MetaRepertoire
  class Line
    def initialize(moves)
      @moves = moves
    end

    def +(move)
      Line.new(@moves + move)
    end
  end
end
