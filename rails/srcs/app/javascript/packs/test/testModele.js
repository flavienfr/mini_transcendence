import $ from "jquery"
import _ from "underscore"
import Backbone from "backbone"

var TestModele = Backbone.Model.extend({
    initialize: function(){
        console.log('This model has been initialized.');
    },
    defaults : {
        id : -1,
        firstName : "",
        lastName : "",
        title : "Not available",
        email : "Not available" 
    }
});

export default TestModele;



