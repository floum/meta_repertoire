STARTING_FEN = 'rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR w KQkq - 0 1'

module MetaRepertoire
  class NullSubtree
    def initialize(line)
      @fen = line.fen
    end

    def inspect
      "END OF TREE: #{@fen}"
    end
  end

  class Subtree
    attr_reader :line, :size
    def initialize(line, size)
      @line = line
      @size = size
      @subtrees = []
    end
  end

  def inspect
    "#{@line} #{@size}"
  end

  private

  def move_count_reduction
    @lichess_responses.size / @size
  end
end
