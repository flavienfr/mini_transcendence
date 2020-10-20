import $ from "jquery"
import _ from "underscore"
import Backbone from "backbone"

import TestView from "./testView.js"

var view = new TestView();

var TestRouter = Backbone.Router.extend({
    routes: {
      '': "ft_1",
    },
  
    ft_1: function() {
        view.render();
    },
  });

  export default TestRouter;