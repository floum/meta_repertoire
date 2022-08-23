module MetaRepertoire
  class LichessFEN
    POPULARITY = 0.1

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

    def size
      @white_wins + @black_wins + @draws
    end

    def meta_move
      @moves.select{|move| move.size > size * POPULARITY }.sort_by(&:expected_value).last
    end
  end
end
