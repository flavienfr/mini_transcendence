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
		name: 'Bonjour',
		avatar: 'Avatar',
		current_status: 'Online',
		points: 42,
		is_admin: true,
	}

});

var user = new User();

var LogView = Backbone.View.extend({
	el : '#inside-page',
	template: _.template($('#log-template').html()),
   /* template: _.template($('#chat_main-template').html()), // append les deux template en 1*/

	initialize : function() {
	  console.log("LogView created");
	},

	render : function() {
	  this.$el.html(this.template);
	  console.log("Render Log");
	  return this;

	}
});

var LiveView = Backbone.View.extend({
  el : '#inside-page',
  template: _.template($('#live-template').html()),
 /* template: _.template($('#chat_main-template').html()), // append les deux template en 1*/

  initialize : function() {
	console.log("LiveView created");
  },

  render : function() {
	this.$el.html(this.template);
	console.log("Render Live");
	return this;

  }
});

var PlayView = Backbone.View.extend({
  el : '#inside-page',
  template: _.template($('#play-template').html()),

  initialize : function() {
	  console.log("PlayView created");
  },

  render : function() {
	this.$el.html(this.template);
	  console.log("Render Play");
	  return this;
  }
});

  
var GuildView = Backbone.View.extend({
  el : '#inside-page',
  template: _.template($('#guild-template').html()),

  initialize : function() {
	  console.log("GuildView created");
  },

  render : function() {
	this.$el.html(this.template);
	  console.log("Render Guild");
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

var WarView = Backbone.View.extend({
  el : '#inside-page',
  template: _.template($('#war-template').html()),

  initialize : function() {
	  console.log("WarView created");
  },

  render : function() {
	this.$el.html(this.template);
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

var TestRouter = Backbone.Router.extend({

initialize : function() {
	  console.log("Router created");
  },

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

var router = new TestRouter();
Backbone.history.start();
