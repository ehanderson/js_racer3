#################FIX SAVE THE WIN #############################


get '/' do

  erb :index
end

get '/results' do
  
  erb :results
end


post '/' do
  new_game = Game.create() 
  player1 = Player.create(name: params[:player1], game_id: new_game.id)
  player2 = Player.create(name: params[:player2], game_id: new_game.id)
  session[:player1] = player1.id
  session[:player2] = player2.id

  redirect('/race')
end

get '/race' do

  erb :race
end

post '/results' do
  @winner_id = params[:player_id]
  p @winner_id.to_i == session[:player1]
  p @winner_id.to_i == session[:player2]
  p @winner_id = @winner_id.to_i
  p session[:player1]
  p session[:player2]
  Player.find(session[:player1]).update(win: @winner_id == session[:player1])
  Player.find(session[:player2]).update(win: @winner_id == session[:player2])

  redirect('/results')
end 


