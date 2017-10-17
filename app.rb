require 'sinatra'
require_relative "change_coin.rb"
require_relative "rando_names.rb"
require_relative "isbn.rb"
require_relative "ttt_board.rb"
require_relative "ttt_player_class.rb"
require_relative "ttt_impossible.rb"

load './local_env.rb' if File.exist?('./local_env.rb')

enable :sessions

get '/' do
erb :index
end

get '/user_names' do
    erb :names
end

post '/user_names' do
  name = params.values
  # .values gets the values of the whole page
  
  pairs = params[:pairs]
  pairs = pairing(name)
  erb :pairs_page, :locals => {:name => name, :pairs => pairs}
end

get '/pairs' do
    name = params[:name]
    pairs = params[:pairs]
    erb :pairs_page, :locals => {:name => name, :pairs => pairs}
end

get '/user_change' do
    erb :coin_change_page
end

post '/user_change' do
    cents_given_to_me = params[:cents_given_to_me]
    coins_given_to_customer = params[:coins_given_to_customer]
    coins_given_to_customer = coin_changer(cents_given_to_me)
   
    redirect '/results?cents_given_to_me=' + cents_given_to_me + '&coins_given_to_customer=' + coins_given_to_customer
end

get '/results' do
    cents_given_to_me = params[:cents_given_to_me]
    coins_given_to_customer = params[:coins_given_to_customer]
   
    erb :results, :locals => {:cents_given_to_me => cents_given_to_me, :coins_given_to_customer => coins_given_to_customer}
end

get '/pizza_delivery' do
    erb :pizza_del
end

post '/pizza_delivery' do
    session[:del_choice] = params[:delivery]
    if
        session[:del_choice] == "no_del"
        redirect '/pizza_index'
    elsif 
        redirect '/pizza_address'
    end
end

get '/pizza_address' do
    erb :pizza_address, locals: {yes_del: session[:del_choice]}
end

post '/pizza_address' do
    session[:del_address] = params[:take_pizza_here]
    session[:del_choice] = params[:yes_del]
    redirect '/pizza_index'
end

get '/pizza_index' do
    erb :pizza_index, locals: {take_pizza_here: session[:del_address]}
end

post '/pizza_choosing' do
    session[:pizza_size] = params[:size]
    session[:sauce_type] = params[:sauce]
    session[:meat_type] = params[:meat]
    session[:veg_type] = params[:veg]
    redirect '/pizza_confirm'
end

get '/pizza_confirm' do
    erb :pizza_confirm, locals: {sauce: session[:sauce_type], meat: session[:meat_type], veg: session[:veg_type], size: session[:pizza_size]}
end

post '/pizza_confirm' do
    session[:pizza_choice] = params[:size_radio]
    session[:sauce_choice] = params[:sauce_radio] 
    session[:meat_choice] = params[:meat_radio]
    session[:veg_choice] = params[:veg_radio]
    current_pizza = params[:total].to_i || 0
    session[:total] = session[:total] || 0
    session[:total] = session[:total] + current_pizza
    redirect '/pizza_results'
end

get '/pizza_results' do
    erb :pizza_results, locals: {sauce_final: session[:sauce_choice], meat_final: session[:meat_choice], veg_final: session[:veg_choice], take_pizza_here: session[:del_address], size_final: session[:pizza_choice], total_final: session[:total]}
end

post '/pizza_results' do
    direction = params[:add_checkout]
    current_pizza_array = params[:pizza_array]
    session[:all_the_pizzas] = session[:all_the_pizzas] || []
    session[:all_the_pizzas] << current_pizza_array
    if direction == "no"
        redirect '/pizza_checkout'
    else
        redirect '/pizza_index'
    end
end

get '/pizza_checkout' do
    erb :pizza_checkout, locals: {total_price: session[:total], final_pizzas: session[:all_the_pizzas]}
end

get '/isbn' do
    erb :isbn
end

post '/isbn' do
    session[:user_given_isbn] = params[:user_given_isbn]
    session[:isbn_truth] = isbn_function(session[:user_given_isbn])
    session[:result_message] = isbn_results(session[:isbn_truth])
    session[:isbn_bucket_truth] = push_to_bucket(session[:user_given_isbn], session[:isbn_truth])
    session[:get_file] = get_file()
    redirect '/isbn_results'
end

get '/isbn_results' do
    erb :isbn_results, locals: {user_given_isbn: session[:user_given_isbn], isbn_truth: session[:isbn_truth], result_message: session[:result_message], isbn_bucket_truth: session[:isbn_bucket_truth], get_file: session[:get_file]}
end

post '/isbn_results' do
    redirect '/isbn_bucket_display'
end

get '/isbn_bucket_display' do
    erb :isbn_bucket_display, locals: {user_given_isbn: session[:user_given_isbn], isbn_truth: session[:isbn_truth], result_message: session[:result_message], isbn_bucket_truth: session[:isbn_bucket_truth], get_file: session[:get_file]}
end

get '/tic_tac_toe' do
    session[:board] = Board.new
    erb :ttt, :locals => {board: session[:board]}
end

post '/player_selection' do
    session[:player1_selected] = params[:player1_selection]
    session[:player2_selected] = params[:player2_selection]
    session[:human1] = 'no'
    session[:human2] = 'no'

    if 
        session[:player1_selected] == 'human_choice1'
        session[:player_one] = Human_class.new('X')
        session[:human1] = 'yes'
    
    elsif
        session[:player1_selected] == 'sequential_choice1'
        session[:player_one] = Sequential_class.new('X')

    elsif
        session[:player1_selected] == 'random_choice1'
        session[:player_one] = Random_class.new('X')

    elsif
        session[:player1_selected] == 'impossible_choice1'
        session[:player_one] = Impossible.new('X')
    end

    if 
        session[:player2_selected] == 'human_choice2'
        session[:player_two] = Human_class.new('O')
        session[:human2] = 'yes'
    
    elsif
        session[:player2_selected] == 'sequential_choice2'
        session[:player_two] = Sequential_class.new('O')

    elsif
        session[:player2_selected] == 'random_choice2'
        session[:player_two] = Random_class.new('O')

    elsif
        session[:player2_selected] == 'impossible_choice2'
        session[:player_two] = Impossible.new('O')
    end

    session[:active_player] = session[:player_one]

    if
        session[:human1] == 'yes'
        redirect '/ttt_board_displayed_form'
    else
        redirect '/computer_move'
    end
end

get '/ttt_board_displayed_form' do
    erb :ttt_board_displayed, locals: {player_one: session[:player_one], player_two: session[:player_two], active_player: session[:active_player].marker, board: session[:board]}
end

get '/computer_move' do
    move = session[:active_player].get_move(session[:board].ttt_board)
    session[:board].update_position(move, session[:active_player].marker)
    
    redirect '/check_game_state'
end

post '/ttt_board_displayed_form' do
    move = params[:player_choice].to_i - 1
    
    if 
        session[:board].valid_position?(move)
        session[:board].update_position(move, session[:active_player].marker)

        redirect '/check_game_state'

    else
        redirect '/ttt_board_displayed_form'
    end
end

get '/check_game_state' do
    if
        session[:board].winner?(session[:active_player].marker)
        message = "#{session[:active_player].marker} is the winner!"
        
        erb :ttt_end_page, locals: {board: session[:board], message: message}

    elsif
        session[:board].full_board?
        message = "It's a tied game . . ."
        
        erb :ttt_end_page, locals: {board: session[:board], message: message}

    else
        if 
            session[:active_player] == session[:player_one]
            session[:active_player] = session[:player_two]
        
        else
            session[:active_player] = session[:player_one]
        end
        
        if
            session[:active_player] == session[:player_one] && session[:human1] == 'yes' || session[:active_player] == session[:player_two] && session[:human2] == 'yes'
            redirect '/ttt_board_displayed_form'
        else 
            redirect '/computer_move'
        end
    end
end
