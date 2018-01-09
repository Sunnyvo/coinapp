class Platform < ApplicationRecord
 has_many :prices, dependent: :destroy
 has_many :coins, through: :prices
 validates :name, presence: true, uniqueness: true, case_sensivtive: false


 def self.coins_distinct(platform)
  platform.coins.distinct
  end
  # def self.request_data(currency)
  #   require 'httparty'
  #   url=`https://api.coinbase.com/v2/prices/#{currency}/spot`
  #   response = HTTParty.get(url)
  #   worth= response.parsed_response['data']['amount']
  # end
end
