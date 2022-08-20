module MetaRepertoire
  class LichessAPI
    def initialize(options)
      @level = options.fetch('level') { 'masters' }
      @db = LichessDB.new(options)
    end

    def fetch(fen)
      fen = @db.fetch(fen)
      unless fen
        fen = FEN.new(fen)
        fen.update(self)
        fen.save
      end
      fen
    end
  end
end
