class Platform < ApplicationRecord
 has_many :coins
 has_many :prices, through: :coins
end
