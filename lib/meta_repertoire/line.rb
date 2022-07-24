module MetaRepertoire
  class Line
    attr_reader :moves

    def initialize(moves)
      @moves = moves
    end

    def +(move)
      Line.new(@moves + move)
    end
  end
end
