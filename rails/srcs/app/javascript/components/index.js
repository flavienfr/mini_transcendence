import { LogView } from "components/views/log";
import { OptionView } from "components/views/option"
import { ProfilView } from "components/views/profil"
import { TournamentView } from "components/views/tournament"
import { LiveView } from "components/views/live"
import { PlayView } from "components/views/play"
import { WarView } from "components/views/war"
import { GuildView } from "components/views/guild"


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