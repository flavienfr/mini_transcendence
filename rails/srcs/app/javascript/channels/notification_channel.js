import consumer from "./consumer"

document.addEventListener("logged", function(event){

consumer.subscriptions.create({channel: "NotificationChannel", room_id: event.detail.id}, {
  connected() {
    console.log("notification_channel_" + event.detail.id);
    // Called when the subscription is ready for use on the server
  },

  disconnected() {
    // Called when the subscription has been terminated by the server
  },

  received(data) {
    console.log("notif");
    console.log(data);
    document.dispatchEvent(new CustomEvent("notif", {
      detail: {data: data}
    }));
    // Called when there's incoming data on the websocket for this channel
  }
});

});
