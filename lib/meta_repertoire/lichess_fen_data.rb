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

    private

    def fetch
      lichess_data = @lichess_config.fetch(@fen)
      @size = lichess_data['white'] + lichess_data['draws'] + lichess_data['black']
      @responses = []
      lichess_data['moves'].each do |move_info|
        @responses << LichessMove.new(@fen, move_info)
      end
    end
  end

  class LichessMove
    attr_reader :size, :move
    attr_accessor :size
    def initialize(fen, data)
      @move = Move.new(fen, data['san'])
      @white_wins = data['white']
      @black_wins = data['black']
      @draws = data['draws']
      @size = @white_wins + @draws + @black_wins
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
