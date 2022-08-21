module MetaRepertoire
  class LineSizeCalculator
    def initialize(fen, size, lichess)
      @fen = fen
      @size = size
      @lichess = lichess
    end

    def compute
      lichess_fen = @lichess.fetch(@fen)
      _responses = lichess_fen.moves
      _result = []
      @size.times do |i|
        _result << _responses.sort_by!(&:size).last.move
        _responses.last.size -= _responses.map(&:size).reduce(:+) / (@size - i + 1)
      end
      _result.group_by(&:san).map do |san, items|
        [Move.new(@fen, san), items.size]
      end
    end
  end
end
