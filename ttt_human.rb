class Human
    attr_reader :marker

    def initialize(marker)
        @marker = marker
    end

    def get_move(ttt_board)
        puts "Your move"
        move = gets.chomp.to_i - 1

        if move < 0 || move > 8
            puts "Choose a valid position"
        elsif ttt_board[move] == ""
            move
            
        else
            puts "Spot already taken"
            get_move(ttt_board)
        end
    end

end

class Sequential
    attr_accessor :marker
    
    def get_move(ttt_board)
        ttt_board.index('')
    end
end