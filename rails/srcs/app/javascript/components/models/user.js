export var User = Backbone.Model.extend({
	urlRoot: "/users",

	defaults: {
		name: 'test',
		avatar: 'test',
		current_status: 'Online',
		points: 42,
		is_admin: true,
	},

	initialize : function() {
		console.log("UserModel created");
	  },

});

var Users = Backbone.Collection.extend({
	modele: User,
	url: "/users",

	initialize : function() {
		console.log("UserCollection created");
		this.fetch({reset: true});
	}
});

export var usercollection = new Users();