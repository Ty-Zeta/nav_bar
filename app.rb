require 'sinatra'
require_relative "change_coin.rb"
require_relative "rando_names.rb"

get '/' do
erb :index
end

get '/user_names' do
    erb :names
end

post '/user_names' do
#   array_names = params[:array_names]
  name = params.values
  pairs = params[:pairs]
  pairs = pairing(name)
  p pairs
  redirect '/pairs_page?pairs=' + pairs + '&name=' + name
  
end

get '/pairs' do
    # array_names = params[:array_names]
    name = params[:name]
    pairs = params[:pairs]
    erb :pairs_page, :locals => {:pairs => pairs, :name => name}
   
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