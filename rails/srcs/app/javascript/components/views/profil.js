export var ProfilView = Backbone.View.extend({
	el : '#inside-page',
	template: _.template($('#profile-template').html()),
  
	initialize : function() {
		console.log("ProfilView created");
	},
  
	render : function() {
	  this.$el.html(this.template);
		console.log("Render Profil");
		return this;
	}
  });