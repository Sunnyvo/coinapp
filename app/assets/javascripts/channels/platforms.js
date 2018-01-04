// app/assets/javascripts/channels/platforms.js

//= require cable
//= require_self
//= require_tree .

this.App = {};
console.log("i am creating!")
App.cable = ActionCable.createConsumer();