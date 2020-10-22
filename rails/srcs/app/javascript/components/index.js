import { User, LogView, LiveView, PlayView, GuildView, OptionView, ProfilView, TournamentView, WarView } from "components/views";

var logview = new LogView();
var liveview = new LiveView();
var playview = new PlayView();
var guildview = new GuildView();
var optionview = new OptionView();
var profilview = new ProfilView();
var tournamentview = new TournamentView();
var warview = new WarView();


var Router = Backbone.Router.extend({
	routes: {
		'': "ft_log",
		'live': "ft_live",
		'play': "ft_play",
		'guild': "ft_guild",
		'option': "ft_option",
		'profil': "ft_profil",
		'tournament': "ft_tournament",
		'war': "ft_war",
	},
	ft_log: function() {
		logview.render();
	},
	ft_live: function() {
		liveview.render();
	},
	ft_play: function() {
		playview.render();
	},
	ft_guild: function() {
		guildview.render();
	},
	ft_option: function() {
		optionview.render();
	},
	ft_profil: function() {
		profilview.render();
	},
	ft_tournament: function() {
		tournamentview.render();
	},
	ft_war: function() {
		warview.render();
	},
});

$( "#logo" ).on( "click", function() {
	Backbone.history.navigate("/", {trigger: true});
});
$( "#nav_to_live" ).on( "click", function() {
	Backbone.history.navigate("/live", {trigger: true});
});
$( "#nav_to_play" ).on( "click", function() {
	Backbone.history.navigate("/play", {trigger: true});
});
$( "#nav_to_guild" ).on( "click", function() {
	Backbone.history.navigate("/guild", {trigger: true});
});
$( "#nav_to_option" ).on( "click", function() {
	Backbone.history.navigate("/option", {trigger: true});
});
$( "#nav_to_profil" ).on( "click", function() {
	Backbone.history.navigate("/profil", {trigger: true});
});
$( "#nav_to_tournament" ).on( "click", function() {
	Backbone.history.navigate("/tournament", {trigger: true});
});
$( "#nav_to_war" ).on( "click", function() {
	Backbone.history.navigate("/war", {trigger: true});
});

var router = new Router();

Backbone.history.start();


/*
** All js files here 
*/

/*
$( "#logo" ).on( "click", function() {
	Backbone.history.navigate("/", {trigger: true});
});
$( "#nav_to_live" ).on( "click", function() {
	Backbone.history.navigate("/live", {trigger: true});
});
$( "#nav_to_play" ).on( "click", function() {
	Backbone.history.navigate("/play", {trigger: true});
});
$( "#nav_to_guild" ).on( "click", function() {
	Backbone.history.navigate("/guild", {trigger: true});
});
$( "#nav_to_option" ).on( "click", function() {
	Backbone.history.navigate("/option", {trigger: true});
});
$( "#nav_to_profil" ).on( "click", function() {
	Backbone.history.navigate("/profil", {trigger: true});
});
$( "#nav_to_tournament" ).on( "click", function() {
	Backbone.history.navigate("/tournament", {trigger: true});
});
$( "#nav_to_war" ).on( "click", function() {
	Backbone.history.navigate("/war", {trigger: true});
});


var User = Backbone.Model.extend({
	urlRoot: "/users",

	defaults: {
		name: 'test',
		avatar: 'test',
		current_status: 'Online',
		points: 42,
		is_admin: true,
	}

});

var LogView = Backbone.View.extend({
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

var LiveView = Backbone.View.extend({
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


var PlayView = Backbone.View.extend({
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

  
var GuildView = Backbone.View.extend({
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

var OptionView = Backbone.View.extend({
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

var ProfilView = Backbone.View.extend({
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

var TournamentView = Backbone.View.extend({
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

var ModelGuild = Backbone.Model.extend();
var guildTest = new ModelGuild();
guildTest.set({
	name: "Guild of war",
	anagram: "GOF",
	points:"1234",
	owner:"didier",
	officer:"" // set empty string for no officer
});

var WarView = Backbone.View.extend({
  el : '#inside-page',
  template: _.template($('#war-template').html()),
  model: guildTest,

  initialize : function() {
	  console.log("WarView created");
  },

  render : function() {
	this.$el.html(this.template(this.model.toJSON()));
	  console.log("Render War");
	  return this;
  }
});


var logview = new LogView();
var liveview = new LiveView();
var playview = new PlayView();
var guildview = new GuildView();
var optionview = new OptionView();
var profilview = new ProfilView();
var tournamentview = new TournamentView();
var warview = new WarView();

var livechatview = new LiveChatView();

var Router = Backbone.Router.extend({
	routes: {
		'': "ft_log",
		'live': "ft_live",
		'play': "ft_play",
		'guild': "ft_guild",
		'option': "ft_option",
		'profil': "ft_profil",
		'tournament': "ft_tournament",
		'war': "ft_war",
	},
	ft_log: function() {
		logview.render();
	},
	ft_live: function() {
		liveview.render();
	},
	ft_play: function() {
		playview.render();
	},
	ft_guild: function() {
		guildview.render();
	},
	ft_option: function() {
		optionview.render();
	},
	ft_profil: function() {
		profilview.render();
	},
	ft_tournament: function() {
		tournamentview.render();
	},
	ft_war: function() {
		warview.render();
	},
});

var router = new Router();
Backbone.history.start();

});
*/