require 'sinatra'
require_relative "change_coin.rb"
require_relative "rando_names.rb"
require_relative "isbn.rb"
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
    if session[:del_choice] == "no_del"
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