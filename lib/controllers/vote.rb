require 'sinatra'
require 'yaml/store'

Choices = {
    Ham: :Hamburger,
    Piz: :Pizza,
    Cur: :Curry,
    Noo: :Noodles
}
get '/' do
  @title = 'Welcome to my sinatra app'
  erb :index
end

post '/cast' do
  @title = 'Thanks for casting'
  @vote = params['vote']
  @store = YAML::Store.new 'votes.yml'
  @store.transaction do
    @store['votes'] ||= {}
    @store['votes'][@vote] ||= 0
    @store['votes'][@vote] += 1
  end
  erb :cast
end

get '/results' do
  @title = 'Results so far:'
  @store = YAML::Store.new 'votes.yml'
  @votes = @store.transaction{@store['votes']}
  erb :results
end