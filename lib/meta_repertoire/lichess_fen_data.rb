module MetaRepertoire
  class LichessFENData
    attr_reader :fen

    def initialize(fen, lichess_config)
      @fen = fen
      @lichess_config = lichess_config
    end

    def size
      fetch unless @size
      @size
    end

    def responses
      fetch unless @responses
      @responses
    end

    def meta_move
      @responses.sort_by(&:expected_value).last
    end

    private

    def fetch
      lichess_data = @lichess_config.fetch(@fen)
      @size = lichess_data['white'] + lichess_data['draws'] + lichess_data['black']
      @responses = []
      lichess_data['moves'].each do |move_info|
        @responses << LichessResponse.new(@fen, move_info['san'], move_info['white'], move_info['black'], move_info['draws'])
      end
    end
  end

  class LichessResponse
    attr_reader :size, :move
    attr_accessor :size
    def initialize(fen, san, white_wins, black_wins, draws)
      @move = Move.new(fen, san)
      @white_wins = white_wins
      @black_wins = black_wins
      @draws = draws
      @size = white_wins + draws + black_wins
    end

    def inspect
      "#{@move} | 1-0: #{@white_wins}, 1/2-1/2: #{@draws}, 0-1: #{@black_wins} | Total: #{@size}"
    end

    def ==(other)
      @move == other.move
    end

    def expected_value
      @move.color == 'white' ? (@white_wins + @draws / 2).to_f / @size : (@black_wins + @draws / 2).to_d / @size
    end
  end
end
