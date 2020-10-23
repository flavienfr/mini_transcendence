export var OptionView = Backbone.View.extend({
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