module MetaRepertoire
  class LichessDB
    ENDPOINT = "https://explorer.lichess.ovh/masters"

    def initialize(filename)
      @db = SQLite3::Database.new filename
      @db.execute <<-SQL
        create table if not exists fen_datas(
          fen varchar(40),
          lichess_response varchar(1000)
        );
      SQL
    end

    def fetch(fen)
      result = @db.query('SELECT * FROM fen_datas WHERE fen=?', [fen])
      if found = result.next
        json = JSON.load(found[1])
      else
        response = Net::HTTP.get(URI.parse("#{ENDPOINT}?fen=#{fen}"))
        statement = @db.prepare("INSERT INTO fen_datas (fen, lichess_response) VALUES (:fen, :json)")
        statement.execute([fen, response])
        json = JSON.load(response)
      end
      json
    end
  end
end
