module MetaRepertoire
  class LichessAPI
    def initialize(options)
      @level = options.fetch('level') { 'masters' }
      @endpoint = "https://explorer.lichess.ovh/masters"
      @endpoint = 'https://explorer.lichess.ovh/lichess' unless @level == 'masters'
    end

    def fetch(fen)
      uri = "#{@endpoint}?fen=#{fen}"
      uri << "&ratings=#{@level}" unless @level == 'masters'
      sleep 0.2
      Net::HTTP.get(URI.parse(uri))
    end
  end
end
