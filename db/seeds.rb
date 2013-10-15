
emily = Player.create(name: "Emily")
zach = Player.create(name: "Zach")
test_game = Game.create()

Player.all.each do |player|
  test_game.players << player
end
