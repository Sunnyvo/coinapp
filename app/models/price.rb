class Price < ApplicationRecord
  belongs_to :platform
  belongs_to :coin
  def self.request_price
    prices = []
    #basecoin platform
    arr_coinbase = [{api: "BTC-USD", platform: "Coinbase", coin: "Bitcoin"},{api: "ETH-USD", platform: "Coinbase", coin: "Ethereum"}];

    #bittrex platform
    arr_bittrex = [{api: "usdt-btc", platform: "Bittrex", coin: "Bitcoin"},{api: "usdt-eth", platform: "Bittrex", coin: "Ethereum"}];

    arr_coinbase.each do |arr|
      _price = request_data_basecoin(arr[:api])
      price = Price.create!(worth: _price, coin_id: Coin.find_by_name(arr[:coin]).id, platform_id: Platform.find_by_name(arr[:platform]).id)
      prices << price
    end

    arr_bittrex.each do |arr|
      _price = Price.request_data_bittrex(arr[:api])
      price = Price.create!(worth: _price, coin_id: Coin.find_by_name(arr[:coin]).id, platform_id: Platform.find_by_name(arr[:platform]).id)
      prices << price
    end
    return prices
  end

  def self.request_data_basecoin(currency)
    require 'httparty'
    url ='https://api.coinbase.com/v2/prices/' + currency
    url = url + '/spot'
    response = HTTParty.get(url)
        worth= response.parsed_response['data']['amount']
    return worth
  end


  def self.request_data_bittrex(currency)
    require 'httparty'
    url ='https://bittrex.com/api/v1.1/public/getmarketsummary?market=' + currency
    response = HTTParty.get(url)
    worth= response.parsed_response['result'].first['Bid']
    return worth
  end

  def self.request_data_poloniex(currency)
    require 'httparty'
    url ='https://poloniex.com/public?command=returnOrderBook&currencyPair=' + currency
    url = url + '&depth=1'
    response = HTTParty.get(url)
    worth = response.parsed_response['bids'].first['0']
    return worth
  end
end
