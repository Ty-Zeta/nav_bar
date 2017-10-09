class Impossible
    attr_accessor :marker, :opponent

    def initialize(marker)
        @marker = marker
        @opponent = get_opponent(@marker)
    end

    def get_opponent(marker)
        opponent = 'X'

        if 
            marker == 'X'
            opponent = 'O'
        
        else
            opponent = 'X'
        end
    end

    def get_win(ttt_board)
        get_win_or_block(ttt_board, marker)
    end

    def get_block(ttt_board)
        get_win_or_block(ttt_board, opponent)
    end

    def get_center(ttt_board)
        if 
            ttt_board[4] == ''
            move = 4
        
        else
            move = 90
        end
    end

    def get_fork(ttt_board)
        if 
            ttt_board[0] == ''
            move = 0

        elsif 
            ttt_board[2] == ''
            move = 2

        elsif 
            ttt_board[6] == ''
            move = 6
        
        elsif 
            ttt_board[8] == ''
            move = 8

        else 
            move = 60
        end
    end

    def empty_side(ttt_board)
        sides = [1,3, 5, 7]
        empty = []

        sides.each do |position|
            if ttt_board[position] == ''
                empty << position
            end
        end

        if 
            empty.length > 0
            move = empty.shift
        
        else
            move = 30
        
        end
        move
    end

    def take_block_fork(ttt_board, player)

        fork_combonations = [
			[ttt_board[0], ttt_board[1], ttt_board[2]],
			[ttt_board[3], ttt_board[4], ttt_board[5]],
			[ttt_board[6], ttt_board[7], ttt_board[8]],
			[ttt_board[0], ttt_board[3], ttt_board[6]],
			[ttt_board[1], ttt_board[4], ttt_board[7]],
			[ttt_board[2], ttt_board[5], ttt_board[8]],
			[ttt_board[0], ttt_board[4], ttt_board[8]],
			[ttt_board[2], ttt_board[4], ttt_board[6]]
            ]
            
        fork_positions = [
            [0, 1, 2],
            [3, 4, 5], 
            [6, 7, 8],
            [0, 3, 6],
            [1, 4, 7],
            [2, 5, 8],
            [0, 4, 8],
            [2, 4, 6]
            ]

        fork_spot = []
        index_position_array = []
        intersections = []

        fork_combonations.each_with_index do |forking_line, index_position|
            if forking_line.count(player) == 1 && forking_line.count('') == 2
                index_position_array << index_position
            end
        end

        index_position_array.each do |index|
            fork_spot << fork_positions[index]
        end

        fork_spot = fork_spot.flatten.sort

        fork_spot.each do |fork_spot_value|
            if ttt_board[fork_spot_value] == ''
                intersections << fork_spot_value
            end
        end
        intersections
    end

    def block_fork(ttt_board)
        intersections = take_block_fork(ttt_board, opponent)

        if 
            ttt_board == ['', '', opponent, '', marker, '', opponent, '', '']
            move = 3

        elsif 
            ttt_board == [opponent, '', '', '', marker, '', '', '', opponent]
            move = 3

        elsif 
            intersections.detect {|match| intersections.count(match) > 1} == nil
            move = 40
        
        else
            move = intersections.detect {|match| intersections.count(match) > 1}
        
        end
        move
    end

    def get_win_or_block(ttt_board, player)

        possible_winning_combos_on_board = [
			[ttt_board[0], ttt_board[1], ttt_board[2]],
			[ttt_board[3], ttt_board[4], ttt_board[5]],
			[ttt_board[6], ttt_board[7], ttt_board[8]],
			[ttt_board[0], ttt_board[3], ttt_board[6]],
			[ttt_board[1], ttt_board[4], ttt_board[7]],
			[ttt_board[2], ttt_board[5], ttt_board[8]],
			[ttt_board[0], ttt_board[4], ttt_board[8]],
			[ttt_board[2], ttt_board[4], ttt_board[6]]
		    ]
        
        possible_winning_combos = [
            [0, 1, 2],
            [3, 4, 5], 
            [6, 7, 8],
            [0, 3, 6],
            [1, 4, 7],
            [2, 5, 8],
            [0, 4, 8],
            [2, 4, 6]
            ]

        move = 80

        possible_winning_combos_on_board.each_with_index do |winning_combo_line, index_position_of_winning_array_set|
            if winning_combo_line.count(player) == 2 && winning_combo_line.count('') == 1
                winning_empty_space = winning_combo_line.index('')
                move = possible_winning_combos[index_position_of_winning_array_set][winning_empty_space]
            else
                move
            end
        end
        move
    end

    def get_move(ttt_board)
        move = 70

        if 
            get_win(ttt_board) <= 8
            move = get_win(ttt_board)
        
        elsif
            get_block(ttt_board) <= 8
            move = get_block(ttt_board)

        elsif
            block_fork(ttt_board) <= 8
            move = block_fork(ttt_board)

        elsif 
            get_center(ttt_board) <= 8
            move = get_center(ttt_board)

        elsif
            get_fork(ttt_board) <= 8
            move = get_fork(ttt_board)

        elsif
            empty_side(ttt_board) <= 8
            move = empty_side(ttt_board)

        else
            move = ttt_board.index('')
        
        end
        move
    end
end

# def get_win_or_block(ttt_board, player)
    
#             possible_moves = [
                # [ttt_board[0], ttt_board[1], ttt_board[2]],
                # [ttt_board[3], ttt_board[4], ttt_board[5]],
                # [ttt_board[6], ttt_board[7], ttt_board[8]]
                # ]
#             move = 0
#             possible_winning_combos = [[0, 1, 2], [3, 4, 5], [6, 7, 8], [0, 3, 6], [1, 4, 7], [2, 5, 8], [0, 4, 8], [2, 4, 6]]
    
#             possible_moves.each_with_index do |winning_combo_line, index_position_of_winning_array_set|
#                 if winning_combo_line.count(player) == 2 && winning_combo_line.count('') == 1
#                     winning_empty_space = winning_combo_line.index('')
#                     move = possible_winning_combos[index_position_of_winning_array_set][winning_empty_space]
#                 else
#                     move
#                 end
#             end
#             move
#         end