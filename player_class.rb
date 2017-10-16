class Player
    attr_accessor :marker
    
    def initialize(marker)
        @marker = marker
    end
end

class Human_class < Player
    attr_reader :marker
end

class Sequential_class < Player
    attr_accessor :marker

    def get_move(ttt_board)
        ttt_board.index { |x| x.is_a?(Integer) }
    end
end

class Random_class < Player
    attr_accessor :marker

    def get_move(ttt_board)
        valid_position = []

        ttt_board.each_with_index do |value, index_position|
            if value.is_a?(Integer)
                valid_position.push(index_position)
            end
        end
        valid_position.sample
    end
end