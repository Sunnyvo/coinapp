class PricesController < ApplicationController
  protect_from_forgery with: :null_session
  def create
    #basecoin platform
    arr_coinbase = [{api: "BTC-USD", platform: "Coinbase", coin: "Bitcoin"},{api: "ETH-USD", platform: "Coinbase", coin: "Ethereum"}];

    #bittrex platform
    arr_bittrex = [{api: "usdt-btc", platform: "Bittrex", coin: "Bitcoin"},{api: "usdt-eth", platform: "Bittrex", coin: "Ethereum"}];

    arr_coinbase.each do |arr|
      _price = request_data_basecoin(arr[:api])
      price = Price.new(worth: _price, coin_id: Coin.find_by_name(arr[:coin]).id, platform_id: Platform.find_by_name(arr[:platform]).id)
      sub_create(price)
    end

    arr_bittrex.each do |arr|
      _price = request_data_bittrex(arr[:api])
      price = Price.new(worth: _price, coin_id: Coin.find_by_name(arr[:coin]).id, platform_id: Platform.find_by_name(arr[:platform]).id)
      sub_create(price)
    end

  end

  def price_params
    params.require(:price)
  end

  #save data and send it to redis for realtime
  def sub_create(price)
      if price.save!
        ActionCable.server.broadcast 'prices',
          price: price.worth,
          coin: price.coin.name,
          platform: price.platform.name
        head :ok
      end
  end
  helper_method :sub_create
end
