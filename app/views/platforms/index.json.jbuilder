
json.platforms platforms do |platform|
  json.name platform.name
  json.coins platform.coins.distinct do |coin|
    json.name coin.name
    json.prices platform.prices.where(coin_id: coin.id).order("updated_at DESC").limit(5) do |price|
      json.price price.worth
    end
  end
end