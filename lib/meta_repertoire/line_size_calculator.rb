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
      return _result if _responses.empty?
      @size.times do |i|
        _result << _responses.sort_by!(&:size).last
        _responses.last.size -= _responses.map(&:size).reduce(:+) / (@size - i + 1)
      end
      _result.group_by(&:move).map do |move, items|
        [move, items.size]
      end
    end
  end
end
