import { usercollection, User } from "components/models/user"

export var LogView = Backbone.View.extend({
	el : '#inside-page',
	template: _.template($('#log-template').html()),
	collection: usercollection,

	initialize : function() {
		// console.log("LogView created");
		this.listenTo(this.collection, 'add remove', this.render, this);
		this.collection.url = "/users.json";
	  	this.collection.fetch();
	  	// console.log(this.collection.toJSON());
	},

	events: {
    	"click #add-user": "add",
    	"click #delete-user": "delete",
    	"click #sign-in ": "sign",
  	},

	render : function() {
	  	// console.log("Render Log");
		this.$el.html(this.template({usr: this.collection.toJSON()}));
	  	return this;

	},

	add: function() {
		// console.log("Add user");
		var user = new User({name : 'test'});
		this.collection.create(user);
		this.render();
	 },
	 
  	delete: function() {
		// console.log("Delete user");
		var users = this.collection.toJSON();
		var user = users[users.length - 1];
		if (user){
			var to_delete = this.collection.get(user.id);
	  		this.collection.url = "/users"
			to_delete.destroy();
	  		// console.log(this.collection.toJSON());
			this.render();
		}	
	 },
	  
	sign: function() {
		let http 			= "https://api.intra.42.fr/oauth/authorize?";
		let client 			= "client_id=235a071025e8e19cdd302e0cff45e29c2b7c2a8b1fd37bc7cdbf4e2edc452729&";
		let redirect 		= "redirect_uri=http%3A%2F%2Flocalhost%3A3000%2F&";
		let response_type 	= "response_type=code&";
		let scope 			= "scope=public&";
		let state 			= "state=a_very_long_random_string_witchmust_be_unguessable";

		let full 			= http + client + redirect + response_type + scope + state;
		// console.log("full:" + full);
		window.location.href = full;
		// console.log("Delete user");
	},

});