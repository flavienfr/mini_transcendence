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
const _ = require("underscore");
window.underscore = _;
window._ = _;

// BOOTSRAP
import 'bootstrap'
const backbone = require('backbone');
Backbone.$ = window.$ = window.jQuery = $;
var bootstrap = require('bootstrap');	

// FLATPCKR (date-time picker)
import flatpickr from "flatpickr"
require("flatpickr/dist/flatpickr.css")

// cloudinary
import 'cloudinary-core'
var cloudinary = require("cloudinary-core"); // If your code is for ES5
global .cl = new cloudinary.Cloudinary({
    cloud_name: "dwcxgy6qt",
    cloudinary_API_Key: "439763265978211",
    cloudinary_API_Secret: "lKJWSNjqFSqgBxLlyLuXSpORYX4"
});
window.cloudinary = cl;
window.cl = cl;
