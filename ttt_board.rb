class Board
    attr_accessor :ttt_board

    def initialize
        @ttt_board = Array.new(9, "")
    end

    def update_position(position, marker)
        ttt_board[position] = marker
    end

    def valid_position?(position)
        if ttt_board[position] == ''
            true
        else
            false
        end
    end

    def valid_input?(input)
        if input.match(/[XxOo]/)
            true
        else
            false
        end
    end

    def full_board?
        ttt_board.count('') == 0
    end

    def winner?(marker)
        winners = [
            [0, 1, 2],
            [3, 4, 5],
            [6, 7, 8],
            [0, 3, 6],
            [1, 4, 7],
            [2, 5, 8],
            [0, 4, 8],
            [2, 4, 6]
        ]

        results = false

        winners.each do |possible_winner_array_set|
            count = 0
            
            possible_winner_array_set.each do |value|
                if ttt_board[value] == marker
                    count += 1

                    if count == 3
                        results = true
                    end
                end
            end
        end
        results
    end
end