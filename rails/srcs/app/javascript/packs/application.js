// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

require("@rails/ujs").start()
require("@rails/activestorage").start()
require("channels")

global .$ = require('jquery');
window.jQuery = $;
window.$ = $;
const _ = require("underscore")
window.underscore = _;
window._ = _;

// BOOTSRAP
import 'bootstrap'
const backbone = require('backbone');
Backbone.$ = window.$ = window.jQuery = $;	// Useless ?
var bootstrap = require('bootstrap');		// Useless ?

// FLATPCKR (date-time picker)
import flatpickr from "flatpickr"
require("flatpickr/dist/flatpickr.css")

// For js in components
//$(document).ready(function() {
//	require("components")
//});