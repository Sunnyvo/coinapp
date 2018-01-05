// app/assets/javascripts/channels/prices.js

function setupPlatform(){
console.log("setup???!!")
App.prices = App.cable.subscriptions.create('PriceChannel',{
  connected: function() {
    console.log("connected server!");
  },
  disconnected: function() {
    console.log("disconnected server!");
  },
  received: function(data) {
    console.log ('I am here')
    $(`#${data.platform}`).find(`#${data.coin}`).text(data.price)
  }
})
}