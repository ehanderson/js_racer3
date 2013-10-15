function Game(player1, player2) {
  this.player1 = player1;
  this.player2 = player2;
  this.boardLength = $('#player1_strip td').size();
  this.startTime = new Date();
}

Game.prototype.onKeyUp = function (event) {
  if (this.winner() == false)
  {
      if (event == 80)  //p
    {
      this.player1.updatePosition();
    }
    else if (event == 81) //q
    {
      this.player2.updatePosition();
    }
    this.render();
  }
  else
  {
    this.endTime = new Date();
    totalTime = this.endTime - this.startTime;
    $.post("/results", {winner: this.winner(), time: totalTime}, function(response) {
      $('#page').html(response);
    })
  }
};

Game.prototype.render = function() {
  $('.active').removeClass('active');
  $('#player1_strip td:nth-child(' + this.player1.position + ')').addClass('active');
  $('#player2_strip td:nth-child(' + this.player2.position + ')').addClass('active');
};

Game.prototype.winner = function() {
  if (this.player1.position >= this.boardLength)
  {
    return this.player1.name;
  }
  else if (this.player2.position >= this.boardLength)
  {
    return this.player2.name;
  }
  else
  {
    return false;
  }
};

function Player(name) {
  this.name = name;
  this.position = 1;
}

Player.prototype.updatePosition = function() {
  this.position++;
};




$(document).ready(function() {
  var player1 = new Player($('#player1').text());
  var player2 = new Player($("#player2").text());
  console.log(player1)
  console.log(player2)
  var game = new Game(player1, player2);

  $(document).on('keyup', function(event) {
      game.onKeyUp(event.which);
  });
});


  // This is called after the document has loaded in its entirety
  // This guarantees that any elements we bind to will exist on the page
  // when we try to bind to them

  // See: http://docs.jquery.com/Tutorials:Introducing_$(document).ready()
