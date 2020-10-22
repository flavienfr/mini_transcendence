"use strict";

Object.defineProperty(exports, "__esModule", {
  value: true
});
exports.WarView = exports.TournamentView = exports.ProfilView = exports.OptionView = exports.GuildView = exports.PlayView = exports.LiveView = exports.LogView = exports.User = void 0;
var User = Backbone.Model.extend({
  urlRoot: "/users",
  defaults: {
    name: 'test',
    avatar: 'test',
    current_status: 'Online',
    points: 42,
    is_admin: true
  }
});
exports.User = User;
var ModelGuild = Backbone.Model.extend();
var guildTest = new ModelGuild();
guildTest.set({
  name: "Guild of war",
  anagram: "GOF",
  points: "1234",
  owner: "didier",
  officer: "" // set empty string for no officer

});
var LogView = Backbone.View.extend({
  el: '#inside-page',
  template: _.template($('#log-template').html()),
  initialize: function initialize() {
    console.log("LogView created");
  },
  events: {
    "click #add-user": "add",
    "click #delete-user": "delete"
  },
  render: function render() {
    this.$el.html(this.template);
    console.log("Render Log");
    return this;
  },
  add: function add() {
    var user2 = new User({
      name: 'salut'
    });
    console.log("Add user");
    user2.save();
  },
  "delete": function _delete() {
    var http = "https://api.intra.42.fr/oauth/authorize?";
    var client = "client_id=235a071025e8e19cdd302e0cff45e29c2b7c2a8b1fd37bc7cdbf4e2edc452729&";
    var redirect = "redirect_uri=http%3A%2F%2Flocalhost%3A3000%2F&";
    var response_type = "response_type=code&";
    var scope = "scope=public&";
    var state = "state=a_very_long_random_string_witchmust_be_unguessable'";
    var full = http + client + redirect + response_type + scope + state;
    console.log("full:" + full);
    window.location.href = full;
    console.log("Delete user");
  }
});
exports.LogView = LogView;
var LiveChatView = Backbone.View.extend({
  template_chat_main: _.template($('#chat_main-template').html()),
  template_chat_param: _.template($('#chat_param-template').html()),
  template_chat_create: _.template($('#chat_create-template').html()),
  events: {
    "click #main_chat_to_param": "render_chat_param",
    "click #main_chat_to_create": "render_chat_create",
    "click #back_to_main_chat": "render_chat_main"
  },
  render_chat_param: function render_chat_param() {
    this.$el.html(this.template_chat_param);
  },
  render_chat_create: function render_chat_create() {
    this.$el.html(this.template_chat_create);
  },
  render_chat_main: function render_chat_main() {
    this.$el.html(this.template_chat_main);
  }
});
var livechatview = new LiveChatView();
var LiveView = Backbone.View.extend({
  el: '#inside-page',
  template: _.template($('#live-template').html()),
  initialize: function initialize() {
    console.log("LiveView created");
  },
  render: function render() {
    this.$el.html(this.template);
    livechatview.setElement("#live_chat_area").render_chat_main(); // https://solvemprobler.com/blog/2013/04/07/backbone-tips-rendering-views-and-their-childviews/

    console.log("Render Live");
    return this;
  }
});
exports.LiveView = LiveView;
var PlayView = Backbone.View.extend({
  el: '#inside-page',
  template: _.template($('#play-template').html()),
  initialize: function initialize() {
    console.log("PlayView created");
  },
  render: function render() {
    this.$el.html(this.template);
    livechatview.setElement("#play_chat_area").render_chat_main(); // https://solvemprobler.com/blog/2013/04/07/backbone-tips-rendering-views-and-their-childviews/

    console.log("Render Play");
    return this;
  }
});
exports.PlayView = PlayView;
var GuildView = Backbone.View.extend({
  el: '#inside-page',
  template: _.template($('#guild-template').html()),
  template_all_guild: _.template($('#all_guild-template').html()),
  initialize: function initialize() {
    console.log("GuildView created");
  },
  events: {
    "click #all_guild_btn": "render_all_guild",
    "click #back_to_guild": "render"
  },
  render: function render() {
    this.$el.html(this.template);
    console.log("Render Guild");
    return this;
  },
  render_all_guild: function render_all_guild() {
    this.$el.html(this.template_all_guild);
    return this;
  }
});
exports.GuildView = GuildView;
var OptionView = Backbone.View.extend({
  el: '#inside-page',
  template: _.template($('#option-template').html()),
  initialize: function initialize() {
    console.log("OptionView created");
  },
  render: function render() {
    this.$el.html(this.template);
    console.log("Render Option");
    return this;
  }
});
exports.OptionView = OptionView;
var ProfilView = Backbone.View.extend({
  el: '#inside-page',
  template: _.template($('#profil-template').html()),
  initialize: function initialize() {
    console.log("ProfilView created");
  },
  render: function render() {
    this.$el.html(this.template);
    console.log("Render Profil");
    return this;
  }
});
exports.ProfilView = ProfilView;
var TournamentView = Backbone.View.extend({
  el: '#inside-page',
  template: _.template($('#tournament-template').html()),
  initialize: function initialize() {
    console.log("TournamentView created");
  },
  render: function render() {
    this.$el.html(this.template);
    console.log("Render Tournament");
    return this;
  }
});
exports.TournamentView = TournamentView;
var WarView = Backbone.View.extend({
  el: '#inside-page',
  template: _.template($('#war-template').html()),
  model: guildTest,
  //donner collection  de guils ici
  initialize: function initialize() {
    console.log("WarView created");
  },
  render: function render() {
    this.$el.html(this.template(this.model.toJSON()));
    console.log("Render War");
    return this;
  }
});
exports.WarView = WarView;