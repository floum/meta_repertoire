module MetaRepertoire
  class LichessAPI
    def initialize(options)
      @level = options.fetch('level') { 'masters' }
      @endpoint = "https://explorer.lichess.ovh/masters"
      @endpoint = 'https://explorer.lichess.ovh/lichess' unless @level == 'masters'
    end

    def fetch(fen)
      Net::HTTP.get(URI.parse("#{@endpoint}?fen=#{fen}"))
    end
  end
end
