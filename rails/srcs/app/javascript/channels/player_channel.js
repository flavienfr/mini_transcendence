import consumer from "./consumer"

consumer.subscriptions.create("PlayerChannel", {
  connected() {
    // Called when the subscription is ready for use on the server
  },

  disconnected() {
    // Called when the subscription has been terminated by the server
  },


  async received(arg) {
    if (arg.current_status) {
      await usercollection.fetch();
      return ;
    }
    await playercollection.fetch();
    var list = playercollection.toJSON();
    if (playercollection.length == 2 && list[0].user_id == current_user_id)
    {
      var data = {
        from_user_id: list[1].user_id,
        to_user_id: list[0].user_id,
        game_type: "ranked_match_making",//possiblité ranked_match_making ou casual_match_making
      }

      Backbone.ajax({
        url: '/ask_for_games/',
        data: JSON.stringify(data),
        type: 'post',
        dataType: 'json',
        contentType: 'application/json',
        success: function(response) {
            console.log("LAUNCH GAME");
            launch_game(response.ask_for_game); 
        },
        error: function(){
          alert("error");
        }
      });
      var tmp = playercollection.findWhere({user_id: list[0].user_id});
      await tmp.destroy();
      tmp = playercollection.findWhere({user_id: list[1].user_id});
      await tmp.destroy();
      return ;
    }
  }
});
