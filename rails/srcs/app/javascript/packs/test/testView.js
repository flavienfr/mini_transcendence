import $ from "jquery"
import _ from "underscore"
import Backbone from "backbone"


var TestView = Backbone.View.extend({
    el : '#test-test',
    events : {
        'click #test-test' : 'clickLive',
        'mouseover #test-test' : 'onMouseover'
    },

    initialize : function() {
    /*    this.template = _.template($('.room_members-template').html());*/
        console.log("View created");
    },

    clickLive : function() {
        console.log("Click !");
        this.render();
    },

    onMouseover : function(event) {
        console.log("Get out !");
    },

    render : function() {
        var that = this;
   /*     this.$el.empty().append('<h2>test test test</h2>');*/
        that.$el.html('<h2>test test test</h2>');
        console.log("Render");
    }
});


export default TestView;