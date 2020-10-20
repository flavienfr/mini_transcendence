/* dependencies */
import $ from "jquery"
import _ from "underscore"
import Backbone from "backbone"

import TestModele from "./testModele.js"
import TestRouter from "./testRouter.js"
/* code */

const Entrypoint = {}

Entrypoint.start = function() {
    /* start backbone */
    console.log("yoyoyo")
    
    var me = new TestModele({
        firstName : "test",
        lastName : "test2",
        title : "CEO",
        email : "test@mangetesmorts.com"
    });
    
    console.log(me)
    
    var router = new TestRouter();

    Backbone.history.start({pushState: true});
    
    /* render components */
    // Navbar.render();
    // Chat.render();
    // Pong.render();
    // Profile.render();
}

export default Entrypoint;