
//_____________________________________ Profil2View _____________________________________
var Profil2View = Backbone.View.extend({
	el : '#inside-page',
	template: _.template($('#profile-template').html()),
	collection: usercollection,
	user_cible: 0,

	events: {
		"click #return": "return_profil",
		"click #add_to_friend": "add_friend",
		"click #ask_a_duel": "ask_duel"
	},
  
	initialize : function() {
		console.log("Profil2View created");
	},
  
	render : async function(id_user) {
		console.log("Render Profil2");
		user_cible = parseInt(id_user);
		await this.collection.fetch();
		user = this.collection.findWhere({id: parseInt(id_user)});
		//guild = new Guild();
		//guild.url = "/guild_participations/" + id_user + ".json"
		//await guild.fetch();

		this.$el.html(this.template({user: user.toJSON()}));
		//this.$el.html(this.template({user: user.toJSON(), guild: guild.toJSON()}));
		return this;
	},

	return_profil : function() {
		Backbone.history.navigate("/profil", {trigger: true});
		Backbone.history.loadUrl();	
	},

	add_friend : async function() {
		friendshipcollection.url = "/friendships/?id=" + current_user_id; 
		await friendshipcollection.fetch();
		if (friendshipcollection.findWhere({id: user_cible}))
		{
			alert("You are already friend !");
		}
		else
		{
			console.log("Add friend");
			var current_id = current_user_id;
			user = this.collection.findWhere({id: parseInt(current_id)});
			user = user.toJSON();
			message = user.name + " send you a friend request";
			type = "add_friend";
			notif = new Notification({from_user_id: current_id, user_id: user_cible, table_type: type, message: message});
			await notif.save();
		}
	},

	ask_duel : async function() {
		console.log("Ask a duel");

		var data = {
			from_user_id: current_user_id,
			to_user_id: user_cible,
            game_type: "duel",
        }
		self = this
		Backbone.ajax({
			url: '/ask_for_games/',
			data: JSON.stringify(data),
			type: 'post',
			dataType: 'json',
			contentType: 'application/json',
			success: function(response) {
				if (response.is_msg){
					Swal.fire("", response.msg, "info");
				}
			},
			error: function(){
				alert("error");
			}
		});
	},
});









$.ajax({
    url: 'users/6/profile', // >
    data: false,
    cache: false,
    contentType: false,
    processData: false,
    type: 'GET',
    success: function(res) {
        console.log("ok res: ", res);
    },
    error: function (err) {
        console.log("ko err:", err);
        Swal.fire({
            icon: 'error',
            title: 'Oops...',
            text: 'Something went wrong!',
            footer: "---"
        })
    }
})










$.ajax({
	url: 'users/' + current_user_id + '/profile?target_user_id=6', // >
	data: false,
	cache: false,
	contentType: false,
	processData: false,
	type: 'GET',
	success: function(res) {
		console.log("ok res: ", res);
		console.log("res.data: ", res.data);
		self.$el.html(self.template({
				current_user: res.data["current_user"],
				target_user: res.data["target_user"],
				guild: res.data["guild"],
				match_history: res.data["match_history"],
				friends: res.data["friends"]
			})
		);
		return self;
	},
	error: function (err) {
		console.log("ko err:", err);
		Swal.fire({
			icon: 'error',
			title: 'Oops...',
			text: 'Something went wrong!',
			footer: "---"
		})
		self.$el.html(self.template({
				current_user: "",
				target_user: "",
				guild: "",
				match_history: "",
				friends: ""
			})
		);
		return self;		
	}
})






<!-- title -->
<%% if (target_user.title_id) { %>
	<h3 class="title">Title: <%%= title.name %></h3>
<%% } else { %>
	<h3 class="title">Title: -</h3>
<%% } %>