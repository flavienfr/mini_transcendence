var ChatView = Backbone.View.extend({
	template_chat_main: _.template($('#chat_main-template').html()),
	template_chat_param: _.template($('#chat_param-template').html()),
	template_chat_create: _.template($('#chat_create-template').html()),
	
	events: {
		"click #main_chat_to_param": "render_chat_param",
		"click #main_chat_to_create": "render_chat_create",
		"click #back_to_main_chat": "render_chat_main"
	},

	render_chat_param : function() {
		this.$el.html(this.template_chat_param);
	},
	render_chat_create : function() {
		this.$el.html(this.template_chat_create);
	},
	render_chat_main : function() {
		this.$el.html(this.template_chat_main);
	}
});

export var chatview = new ChatView();