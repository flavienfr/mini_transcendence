export var TournamentView = Backbone.View.extend({
	el : '#inside-page',
	template: _.template($('#tournament-template').html()),
  
	initialize : function() {
		// console.log("TournamentView created");
	},
  
	render : function() {
	  this.$el.html(this.template);
		// console.log("Render Tournament");
		return this;
	}
});