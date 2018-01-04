class PricesController < ApplicationController
  def create
    price = Price.new(price_params)
    price.user = current_user
    if price.save
      ActionCable.server.broadcast 'prices',
        price: price.content,
        user: price.user.username
      head :ok
    end
  end
  def price_params
    params.require(:price).permit(:worth, :platform_id, :coin_id)
  end
end
