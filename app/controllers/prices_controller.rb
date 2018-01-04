class PricesController < ApplicationController
  def create
    eth_price = request_data_basecoin("ETH-USD")
    price = Price.new(price_params: eth_price, coin_id: "1", platform_id: "1")
    if price.save!
      ActionCable.server.broadcast 'prices',
        price: price.worth,
        coin: price.coin.name,
        platform: price.platform.name
      head :ok
    end
  end
  def price_params
    params.require(:price).permit(:platform_id, :coin_id)
   end
end
