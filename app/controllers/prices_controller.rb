class PricesController < ApplicationController
  # protect_from_forgery with: :null_session
  def create
    #basecoin platform
    arr_coinbase = [{api: 'BTC-USD', platform: 'Coinbase', coin: 'Bitcoin'},{api: 'ETH-USD', platform: 'Coinbase', coin: 'Ethereum'}];

    #bittrex platform
    arr_bittrex = [{api: 'usdt-btc', platform: 'Bittrex', coin: 'Bitcoin'},{api: 'usdt-eth', platform: 'Bittrex', coin: 'Ethereum'}];

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

  def fetch_prices_coin
    if (params[:coin] != '1' &&  params[:coin] != '2')
      params[:coin] = '1'
    end
      if (params[:platform] != '1' && params[:platform] != '2' && params[:platform] != '3')
      params[:platform] = '1'
    end
    prices = Price.where(platform_id: params[:platform], coin_id: params[:coin]).order('updated_at DESC').limit(5)
    render json: prices.to_json
  end


  def index
    @platforms = Price.data_of_platform_market
    
  end

end
