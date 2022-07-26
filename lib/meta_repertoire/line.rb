module MetaRepertoire
  class Line
    def initialize(moves, size, repertoire)
      @moves = moves
      @fen = moves.last.resulting_fen
      @repertoire = repertoire
      @size = size
      @sublines = []
      compute_sublines
    end

    def inspect
      "Line: #{@moves} | size: #{@size} | Sublines: #{@sublines}"
    end

    def pretty_print
      "#{@moves.map(&:san).join(' ')} | #{@size} games \n" << 
      @sublines.map(&:pretty_print).join("\n")
    end

    def compute_sublines
      return if @size <= 2
      line_sizes = LineSizeCalculator.new(@fen, @size, @repertoire.lichess_db).compute
      line_sizes.each do |move, size|
        if @repertoire.answer(move)
          @sublines << Line.new(@moves.dup << move << @repertoire.answer(move), size, @repertoire)
        else
          @sublines << NullLine.new(@moves.dup << move, size, @repertoire)
        end
      end
    end
  end

  class NullLine < Line
    def initialize(moves, size, repertoire)
      @moves = moves
      @size = size
      p "  - #{@moves.map(&:san).join(' ')} | size: #{@size}" if @size > 1
      @sublines = []
    end

    def inspect
      "<SeveredLine: #{@moves} | size: #{@size}>"
    end

    def compute_sublines
    end
  end
end
