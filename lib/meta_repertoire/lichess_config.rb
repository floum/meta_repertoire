module MetaRepertoire
  class LichessConfig
    attr_reader :endpoint, :db
    def initialize(options)
      @level = options.fetch('level') { 'masters' }
      case @level
      when 'masters'
        @endpoint = "https://explorer.lichess.ovh/masters"
        @db = 'lichess_masters.sqlite3'
      else
        @endpoint = 'https://explorer.lichess.ovh/lichess'
        @db = "lichess_#{@level}.sqlite3"
      end
    end

    def inspect
      "Conf: #{@endpoint} | #{@db}"
    end
  end
end
