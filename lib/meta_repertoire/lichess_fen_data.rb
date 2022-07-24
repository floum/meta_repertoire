module MetaRepertoire
  class LichessFENData
    ENDPOINT = "https://explorer.lichess.ovh/masters"
    attr_reader :fen

    def initialize(fen)
      @fen = fen
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
      lichess_data = JSON.load(Net::HTTP.get(URI.parse("#{ENDPOINT}?fen=#{fen}")))
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
