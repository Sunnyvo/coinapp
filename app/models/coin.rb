class Coin < ApplicationRecord
  has_many :prices
  has_many :platforms, through: :prices
  validates :name, presence: true, uniqueness: true, case_sensitive: false
end
