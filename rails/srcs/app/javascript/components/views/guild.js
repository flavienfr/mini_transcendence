export var GuildView = Backbone.View.extend({
	el : '#inside-page',
	template: _.template($('#guild-template').html()),
	template_all_guild: _.template($('#all_guild-template').html()),

	initialize : function() {
		console.log("GuildView created");
		console.log("GuildView created");
		console.log("GuildView created");
	},

	events: {
		"click #all_guild_btn": "render_all_guild",
		"click #back_to_guild": "render"
	},

	render : function() {
		this.$el.html(this.template);
		console.log("Render Guild");
		console.log("Render Guild");
		return this;
	},
	render_all_guild : function(){
		this.$el.html(this.template_all_guild);
		return this;
	}
});