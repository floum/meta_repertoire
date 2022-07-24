module MetaRepertoire
  class SubtreeCalculator
    def initialize(line, size)
      @line = line
      @size = size
    end

    def compute
      _responses = @line.lichess_responses
      _size = @size
      _result = []
      _size.times do
        _result << _responses.sort_by!(&:size).last.move
        _responses.last.size -= @line.lichess_size / @line.lichess_responses.size
      end
      _result.group_by(&:san).map do |san, items|
        [Move.new(@line.fen, san), items.size]
      end.map do |move, size|
        Subtree.new(@line + move, size)
      end
    end
  end
end
