// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

import 'bootstrap'

require("@rails/ujs").start()
require("@rails/activestorage").start()
require("channels")

global .$ = require('jquery');
window.jQuery = $;
window.$ = $;
const _ = require("underscore")
window.underscore = _;
window._ = _;
const backbone = require('backbone');
Backbone.$ = window.$ = window.jQuery = $;  // nécessaire pour bootstrap
var bootstrap = require('bootstrap');

//$(document).ready(function() {
//	require("components")
//});