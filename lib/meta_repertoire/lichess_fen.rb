module MetaRepertoire
  class LichessFEN
    attr_reader :moves
    def initialize(fen, data)
      @fen = fen
      @moves = []
      @white_wins = data['white']
      @black_wins = data['black']
      @draws = data['draws']
      data['moves'].each do |move|
        @moves << LichessMove.new(@fen, move)
      end
    end

    def meta_move(tendency)
      @moves.sort_by(&:value)
    end
  end
end
