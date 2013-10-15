#################FIX SAVE THE WIN #############################
get '/reset_game_number' do

end

get '/' do

  erb :index
end

get '/results' do
  
  erb :results
end


post '/' do
  @player1 = Player.where(name: params[:player1]).first_or_create
  @player2 = Player.where(name: params[:player2]).first_or_create
  @game = Game.create
  @appearance1 = Appearance.create(player_id: @player1.id, game_id: @game.id)
  @appearance2 = Appearance.create(player_id: @player2.id, game_id: @game.id)
  session[:player1] = @player1.name
  session[:player2] = @player2.name

  redirect('/race')
end

get '/race' do
  erb :race
end

post '/results' do
  @player1 = Player.find_by_name(session[:player1])
  @player1.appearances.last.update_attributes(win: (params[:winner] == session[:player1]))
  @player2 = Player.find_by_name(session[:player2]).appearances.last.update_attributes(win: (params[:winner] == session[:player2]))
  @game = Game.find(@player1.appearances.last.game_id)
  @game.update_attributes(elapsed_time: params[:time].to_i)
  @winner = Player.find(Appearance.where(win: true).last.player_id)

  if request.xhr?
    erb :results
  end
end 

get '/logout' do
  session.clear
  redirect '/'
end


