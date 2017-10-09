class Random
    attr_accessor :marker

    def initialize(marker)
        @marker = marker
    end

    def get_move(ttt_board)
        valid_position = []

        ttt_board.each_with_index do |value, index_position|
            if value == ''
                valid_position << index_position
            end
        end
        valid_position.sample
    end
end
