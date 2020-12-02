import consumer from "./consumer"
document.addEventListener("logged", function(event){

consumer.subscriptions.create({channel: "NotificationChannel", room_id: event.detail.id}, {
  connected() {
    // Called when the subscription is ready for use on the server
  },

  disconnected() {
    // Called when the subscription has been terminated by the server
  },

  received(data) {
  if (data.sender || data.kicked_from || data.refresh || data.channel_destroyed || data.refresh_tournament_details_id) {
    // console.log("notif");
    // console.log(data);
    document.dispatchEvent(new CustomEvent("notif", {
      detail: {data: data}
    }));
  }
  if (data.game)
  {
    console.log("---------->>>>>>>>>>");
    document.dispatchEvent(new CustomEvent("start_game", {
      detail: {data: data}
    }));
  }
  if (data.notification) {
    document.dispatchEvent(new CustomEvent("notif2", {}));
  }
  if (data.ban) {
    window.location.reload();
  }

    // Called when there's incoming data on the websocket for this channel
  }
});

});
