import consumer from "./consumer"

consumer.subscriptions.create("PlayerChannel", {
  connected() {
    // Called when the subscription is ready for use on the server
  },

  disconnected() {
    // Called when the subscription has been terminated by the server
  },

  async received(data) {
    await playercollection.fetch();
    var list = playercollection.toJSON();
  //  for (let i = 0; i < playercollection.length; i++)
  //  {
      if (playercollection.length == 2 && list[0].user_id == current_user_id)
      {
        socket_notif.send(JSON.stringify({
        command: "message",
        identifier: JSON.stringify({
            channel: "PongnotChannel",
            pong_id: 0
            }),
            data: JSON.stringify({
                data: {play: "true", id_host: list[0].user_id, id_guest: list[1].user_id}  // send a message to the guest for play with host, it s send his id et the id of the guest
            })
        }));
        playview.render();
        setTimeout(() => {pongguest.setElement("#pong-area").render();}, 800);  
        var tmp = playercollection.findWhere({user_id: list[0].user_id});
        await tmp.destroy();
        tmp = playercollection.findWhere({user_id: list[1].user_id});
        await tmp.destroy();
        return ;
      }
  //  }
    // Called when there's incoming data on the websocket for this channel
  }
});
