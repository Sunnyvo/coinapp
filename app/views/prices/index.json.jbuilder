
# json.platforms platforms do |platform|
#   json.name platform.name
#   json.coins platform.coins.distinct do |coin|
#     json.name coin.name
#     json.prices platform.prices.where(coin_id: coin.id).order("updated_at DESC").limit(5) do |price|
#       json.price price.worth
#     end
#   end
# end
  i = 0
  json.platforms platforms do |coins|
    if(coins != nil)
      json.id (i=i+1)
      json.name Platform.find_by_id(i).name
      j = 0
      json.coins coins do |prices|
        if(prices != nil)
          json.id (j=j+1)
          json.name Coin.find_by_id(j).name
            json.prices prices do |price|
            if(price != nil)
              json.(price,:date, :open, :close, :low, :high)
            end
          end
        end
      end
    end
  end


  # json.platforms platforms do |market|
  #   json.name market.name
  #   json.coins market.coins.distinct do |coin|
  #     json.name coin.name
  #     json.prices market.prices.where(coin_id: coin.id).order("updated_at DESC").limit(1) do |price|
  #       json.price price.worth
  #     end
  #   end
  # end