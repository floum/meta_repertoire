module MetaRepertoire
  class LineSizeCalculator
    def initialize(fen, size, lichess_db)
      @fen = fen
      @size = size
      @lichess_db = lichess_db
    end

    def compute
      lichess = LichessFENData.new(@fen, @lichess_db)
      _responses = lichess.responses
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
