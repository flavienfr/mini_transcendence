export var User = Backbone.Model.extend({
	urlRoot: "/users",

	defaults: {
		name: 'test',
		avatar: 'test',
		current_status: 'Online',
		points: 42,
		is_admin: true,
	}

});

/****** froussel model */
var Guild = Backbone.Model.extend({
	defaults:{
		name: "",
		anagram: "",
		points:"",
		owner:"",
		officer:"" 
	}
});
var Guilds = Backbone.Collection.extend({
	model: Guild,
});

var guild_1 = new Guild({
	name: "Guild of war",
	anagram: "GOF",
	points:"1234",
	owner:"didier",
	officer:"" // set empty string for no officer
});
var guild_2 = new Guild({
	name: "Les zouzes",
	anagram: "SOS",
	points:"5866",
	owner:"sapien",
	officer:"homo" // set empty string for no officer
});
var guild_3 = new Guild({
	name: "Les toros",
	anagram: "RED",
	points:"41",
	owner:"vicache",
	officer:"los" // set empty string for no officer
});
var guilds = new Guilds([guild_1, guild_2, guild_3]);
/**********************/

export var LogView = Backbone.View.extend({
	el : '#inside-page',
	template: _.template($('#log-template').html()),

	initialize : function() {
	  console.log("LogView created");
	},

	events: {
    "click #add-user": "add",
    "click #delete-user": "delete",
  	},

	render : function() {
	  this.$el.html(this.template);
	  console.log("Render Log");
	  return this;

	},

	add: function() {
		var user2 = new User({name : 'salut'});
		console.log("Add user");
		user2.save();
  },

  delete: function() {
	let http 			= "https://api.intra.42.fr/oauth/authorize?";
	let client 			= "client_id=235a071025e8e19cdd302e0cff45e29c2b7c2a8b1fd37bc7cdbf4e2edc452729&";
	let redirect 		= "redirect_uri=http%3A%2F%2Flocalhost%3A3000%2F&";
	let response_type 	= "response_type=code&";
	let scope 			= "scope=public&";
	let state 			= "state=a_very_long_random_string_witchmust_be_unguessable'";

	let full 			= http + client + redirect + response_type + scope + state;

	console.log("full:" + full);
	window.location.href = full;
	console.log("Delete user");
	},

});

var LiveChatView = Backbone.View.extend({
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

var livechatview = new LiveChatView();

export var LiveView = Backbone.View.extend({
	el : '#inside-page',
	template: _.template($('#live-template').html()),

	initialize : function() {
		console.log("LiveView created");
	},

	render : function() {
		this.$el.html(this.template);
        livechatview.setElement("#live_chat_area").render_chat_main(); // https://solvemprobler.com/blog/2013/04/07/backbone-tips-rendering-views-and-their-childviews/
		console.log("Render Live");
		return this;
	},
});

export var PlayView = Backbone.View.extend({
	el : '#inside-page',
	template: _.template($('#play-template').html()),
	
	initialize : function() {
		console.log("PlayView created");
	},

	render : function() {
		this.$el.html(this.template);
		livechatview.setElement("#play_chat_area").render_chat_main(); // https://solvemprobler.com/blog/2013/04/07/backbone-tips-rendering-views-and-their-childviews/
		console.log("Render Play");
		return this;
	}
});
  
export var GuildView = Backbone.View.extend({
	el : '#inside-page',
	template: _.template($('#guild-template').html()),
	template_all_guild: _.template($('#all_guild-template').html()),

	initialize : function() {
		console.log("GuildView created");
	},

	events: {
		"click #all_guild_btn": "render_all_guild",
		"click #back_to_guild": "render"
	},

	render : function() {
		this.$el.html(this.template);
		console.log("Render Guild");
		return this;
	},
	render_all_guild : function(){
		this.$el.html(this.template_all_guild);
		return this;
	}
});

export var OptionView = Backbone.View.extend({
  el : '#inside-page',
  template: _.template($('#option-template').html()),

  initialize : function() {
	  console.log("OptionView created");
  },

  render : function() {
	this.$el.html(this.template);
	  console.log("Render Option");
	  return this;
  }
});

export var ProfilView = Backbone.View.extend({
  el : '#inside-page',
  template: _.template($('#profil-template').html()),

  initialize : function() {
	  console.log("ProfilView created");
  },

  render : function() {
	this.$el.html(this.template);
	  console.log("Render Profil");
	  return this;
  }
});

export var TournamentView = Backbone.View.extend({
  el : '#inside-page',
  template: _.template($('#tournament-template').html()),

  initialize : function() {
	  console.log("TournamentView created");
  },

  render : function() {
	this.$el.html(this.template);
	  console.log("Render Tournament");
	  return this;
  }
});

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
		console.log("change", guild_name);
		console.log("model", guild_to_print.attributes);
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

/*
export var WarView = Backbone.View.extend({
	el : '#inside-page',
	template: _.template($('#war-template').html()),
	//template_guilds: _.template($('#war-guild-template').html()),
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
		console.log("change", guild_name);
		console.log("model", guild_to_print.attributes);
		this.model = guild_to_print;
		//this.render();

		//DOM to change value
	},
	render : function() {
		console.log("model render:", this.model.attributes);
		// Try do modify template before rendering 
		this.$el.html(this.template());
		//this.$('.war_pannel_header').html(this.template_guilds(this.model.toJSON()));

		_.each(this.collection.toJSON(), function(model){
			$('#guild_drop_down').append(
				$('<option></option>').html(model.name)
			);
		});

		return this;
	}
});*/