import consumer from "./consumer"

document.addEventListener('turbolinks:load', () => {

  const element = document.getElementById("pong-id");
  pong_id = element.getAttribute("data-pong-id");
  consumer.subscriptions.create({channel: "PongChannel", pong_id: pong_id}, {
    connected() {
      // Called when the subscription is ready for use on the server
    },
  
    disconnected() {
      // Called when the subscription has been terminated by the server
    },
  
    received(data) {
      // Called when there's incoming data on the websocket for this channel
    }
  });


})

