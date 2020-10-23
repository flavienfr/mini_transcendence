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