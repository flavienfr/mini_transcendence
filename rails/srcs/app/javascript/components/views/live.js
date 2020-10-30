import { chatview } from "components/views/chat"

export var LiveView = Backbone.View.extend({
	el : '#inside-page',
	template: _.template($('#live-template').html()),

	initialize : function() {
		console.log("LiveView created");
	},

	render : function() {
		this.$el.html(this.template);
        chatview.setElement("#chat_area").render_chat_main(); // https://solvemprobler.com/blog/2013/04/07/backbone-tips-rendering-views-and-their-childviews/
		console.log("Render Live");
		return this;
	},
});
