module MetaRepertoire
  class LichessAPI
    attr_reader :endpoint

    def initialize(options)
      @level = options.fetch('level') { 'masters' }
      @endpoint = "https://explorer.lichess.ovh/masters"
      @endpoint = 'https://explorer.lichess.ovh/lichess' unless @level == 'masters'
    end
  end
end
