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

/*****Test guild ***/
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

export var guilds = new Guilds([guild_1, guild_2, guild_3]);