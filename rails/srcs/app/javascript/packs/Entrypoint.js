/* dependencies */
import $ from "jquery"
import _ from "underscore"
import Backbone from "backbone"

/* code */
const Entrypoint = {}

Entrypoint.start = function() {
    /* start backbone */
    Backbone.history.start({pushState: true});

    /* render components */
    // Navbar.render();
    // Chat.render();
    // Pong.render();
    // Profile.render();
}

export default Entrypoint;