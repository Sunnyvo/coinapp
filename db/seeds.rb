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

time =Time.now - 2.days
1000.times do
  Price.create!(worth: rand(11000.111...16000.11),platform_id: rand(1..3),coin_id: 1, created_at: time)
  time = time +150
end

time2=Time.now - 2.days
1000.times do
  Price.create!(worth: rand(800.00...1000.11),platform_id: rand(1..3),coin_id: 2, created_at: time2)
  time2 = time2 +150
end
