
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

