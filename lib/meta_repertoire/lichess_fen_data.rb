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
        @responses << LichessResponse.new(@fen, move_info['san'], move_info['white'] + move_info['black'] + move_info['draws'])
      end
    end
  end

  class LichessResponse
    attr_reader :size, :move
    attr_accessor :size
    def initialize(fen, move, size)
      @move = Move.new(fen, move)
      @size = size
    end

    def inspect
      "#{@move} | #{@size}"
    end

    def ==(other)
      @move == other.move
    end
  end
end
