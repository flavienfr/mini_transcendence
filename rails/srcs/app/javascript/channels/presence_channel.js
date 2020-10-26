import consumer from "./consumer"

document.addEventListener("logged", function(event){


consumer.subscriptions.create("PresenceChannel", {
  connected() {
    console.log("presence id: " + event.detail.id);
    // Called when the subscription is ready for use on the server
  },

  disconnected() {
    // Called when the subscription has been terminated by the server
  },

  received(data) {
    // Called when there's incoming data on the websocket for this channel
  }
});

});
