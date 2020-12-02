import { guilds } from "components/models/guild"

export var WarView = Backbone.View.extend({
	el : '#inside-page',
	template: _.template($('#war-template').html()),
	template_guilds: _.template($('#war-guild-template').html()),
	collection: guilds,
	model: null,

	initialize : function() {
		this.model= this.collection.first();
	},
	events: {
		"change #guild_drop_down": "render_guild_info"
	},
	render_guild_info : function() {
		var guild_name = $("#guild_drop_down option:selected").text();
		var guild_to_print = this.collection.findWhere({name: guild_name});
		// console.log("change", guild_name);
		// console.log("model", guild_to_print.attributes);
		this.model = guild_to_print;
		this.$('.war_pannel_header').html(this.template_guilds(this.model.toJSON()));
	},
	render : function() {
		this.$el.html(this.template(this.model.toJSON()));
		this.$('.war_pannel_header').html(this.template_guilds(this.model.toJSON()));

		// Try do modify template before rendering
		_.each(this.collection.toJSON(), function(model){
			$('#guild_drop_down').append(
				$('<option></option>').html(model.name)
			);
		});

		return this;
	}
});