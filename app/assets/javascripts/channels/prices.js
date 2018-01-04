// app/assets/javascripts/channels/prices.js

App.prices = App.cable.subscriptions.create('PricesChannel',{
  recveived: function(data) {
    $('#btc-cb').innerHTML ="b"
  }
})