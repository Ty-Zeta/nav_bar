require 'sinatra'
require_relative "change_coin.rb"

get '/' do
erb :index
end

get '/user_change' do
    erb :coin_change_page
end

post '/user_change' do
    cents_given_to_me = params[:cents_given_to_me]
    coins_given_to_customer = params[:coins_given_to_customer]
    coins_given_to_customer = coin_changer(cents_given_to_me)
    # stuff = hash_converter(coins_given_to_customer)
    redirect '/results?cents_given_to_me=' + cents_given_to_me + '&coins_given_to_customer=' + coins_given_to_customer
end

get '/results' do
    cents_given_to_me = params[:cents_given_to_me]
    coins_given_to_customer = params[:coins_given_to_customer]
    erb :results, :locals => {:cents_given_to_me => cents_given_to_me, :coins_given_to_customer => coins_given_to_customer}
end