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
    await usercollection.fetch();
    var list_ranked = playercollection.where({game_type: "ranked"});
    var list_casual = playercollection.where({game_type: "casual"});

    var player;

    //---------------- ranked ------------------------
    for(let i = 0; i < list_ranked.length; i++)
    {
      player = usercollection.get({id: list_ranked[i].toJSON().user_id}).toJSON();
      if (player && (player.current_status == "logged out" || player.current_status == "banned")) 
      {
        await list_ranked[i].destroy();
      }
    } 
    if (list_ranked.length == 2 && list_ranked[0].toJSON().user_id == current_user_id)
    {
      var data = {
        from_user_id: list_ranked[1].toJSON().user_id,
        to_user_id: list_ranked[0].toJSON().user_id,
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
        error: async function(response){
        	console.log("erreur 88");
        	for(let i = 0; i < list_ranked.length; i++)
        	{
        	  player = usercollection.get({id: list_ranked[i].toJSON().user_id}).toJSON();
        	  if (player && (player.current_status == "logged out" || player.current_status == "banned")) 
        	  {
        	    await list_ranked[i].destroy();
        	  }
        	} 
        	if (response.status == 422){
				response = response.responseJSON;
				if (response.is_msg){
					Swal.fire("", response.msg, "error");
				}
			}
			else{
				Swal.fire("", "error: " + response.status, "error");
			}
        }
      });
      await list_ranked[0].destroy();
      await list_ranked[1].destroy();
      return ;
    }

    //---------------- casual ------------------------
    for(let i = 0; i < list_casual.length; i++)
    {
      player = usercollection.get({id: list_casual[i].toJSON().user_id}).toJSON();
      if (player.current_status == "logged out") 
      {
        await list_casual[i].destroy();
      }
    } 
    if (list_casual.length == 2 && list_casual[0].toJSON().user_id == current_user_id)
    {
      var data = {
        from_user_id: list_casual[1].toJSON().user_id,
        to_user_id: list_casual[0].toJSON().user_id,
        game_type: "casual_match_making",
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
      await list_casual[0].destroy();
      await list_casual[1].destroy();
      return ;
    }

  }
})