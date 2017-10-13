class Sequential
    attr_accessor :marker
    
    def initialize(marker)
        @marker = marker
    end
    
    def get_move(ttt_board)
        ttt_board.index { |x| x.is_a?(Integer) }
    end
end