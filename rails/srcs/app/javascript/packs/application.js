// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

/* Bootstrap */
import 'bootstrap'

/* à quoi ça sert ? */
require("@rails/ujs").start()
require("@rails/activestorage").start()

/* require les fichiers dans ../channels/*.js */
require("channels")

/* jquery */
global .$ = require('jquery');
window.jQuery = $;
window.$ = $;

/* underscore */
const _ = require("underscore")
window.underscore = _;
window._ = _;

/* backbone */
const backbone = require('backbone');

/* js */
import Entrypoint from "./Entrypoint.js"

/* code */
$(document).ready(Entrypoint.start());