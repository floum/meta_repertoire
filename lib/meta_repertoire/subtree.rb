ENDPOINT = "https://explorer.lichess.ovh/masters"

STARTING_FEN = 'rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR w KQkq - 0 1'

module MetaRepertoire
  class NullSubtree
    def initialize(moves)
      @fen = moves.last.resulting_fen
    end

    def inspect
      "END OF TREE: #{@fen}"
    end
  end

  class Subtree
    def initialize(moves, game_count)
      @moves = moves
      @fen = moves.last.resulting_fen
      @game_count = game_count
      lichess_data = JSON.load(Net::HTTP.get(URI.parse("#{ENDPOINT}?fen=#{@fen}")))
      @lichess_size = lichess_data['white'] + lichess_data['draws'] + lichess_data['black']
      @lichess_responses = lichess_data['moves'-].map do |move_info|
        KnownMove.new(@fen, move_info['san'], move_info['white'] + move_info['draws'] + move_info['black'])
      end
      @subtrees = []
    end
  end

  def build_subtrees
    return if @game_count == 1
    _responses = @lichess_responses
    responses = []
    while responses.size < @game_count
      _responses.sort_by!(&:count).reverse
      responses << _responses.first
      _responses.first.count -= move_count_reduction
    end
    responses.group_by(&:self).map{|key, item| [key, item.count]}.each{|move, count|}
      if @known_positions.map(&:fen).include?(move.resulting_fen)
        @subtrees << Subtree.new(, )
      else
        @subtrees << NullSubtree.new(@moves << move)
      end
    end
  end

  private

  def move_count_reduction
    @lichess_responses.size / @size
  end
end
