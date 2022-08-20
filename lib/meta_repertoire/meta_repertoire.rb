module MetaRepertoire
  class MetaRepertoire < Repertoire
    def initialize(options)
      @lichess_api = LichessAPI.new(options)
      @color = options['color']
    end

    def pretty_print
      "#{@color}\n" << super
    end
  end
end
