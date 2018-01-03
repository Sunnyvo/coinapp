class Coin < ApplicationRecord
  has_many :platforms
  has_many :prices, through: :platforms
end
