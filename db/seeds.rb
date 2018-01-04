# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

coins_list = ["Bitcoin","Ethereum"]
platforms_list = ["Coinbase", "Bittrex", "Poloniex"]



platforms_list.each do |platform|
  Platform.create!(name: platform)
end

coins_list.each do |coin|
  Coin.create!(name: coin)
end

20.times do
  Price.create!(worth: rand(2000),platform_id: rand(1..3),coin_id: rand(1..2))
end