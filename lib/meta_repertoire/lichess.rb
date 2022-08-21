module MetaRepertoire
  class Lichess
    def initialize(options)
      @level = options.fetch('level') { 'masters' }
      @db_filename = "lichess_#{@level}.sqlite3"
      @db = SQLite3::Database.new @db_filename
      @db.execute <<-SQL
        create table if not exists fen_datas(
          fen varchar(40),
          lichess_response varchar(1000),
          created_at text
        );
      SQL
      @api = LichessAPI.new(options)
    end

    def fetch(fen)
      result = @db.query('SELECT * FROM fen_datas WHERE fen=?', [fen])
      if found = result.next
        json = JSON.load(found[1])
      else
        response = @api.fetch(fen)
        json = JSON.load(response)
        statement = @db.prepare("INSERT INTO fen_datas (fen, lichess_response) VALUES (:fen, :json)")
        statement.execute([fen, response])
      end
      LichessFEN.new(fen, json)
    end
  end
end
