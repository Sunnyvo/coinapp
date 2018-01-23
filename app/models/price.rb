class Price < ApplicationRecord
  belongs_to :platform
  belongs_to :coin
  searchkick
  scope :search_import, -> { includes(:platform, :coin)}
  def search_data
    {
      created_at: created_at,
      worth: worth,
      platform_id: platform_id,
      coin_id: coin_id
    }
  end

  def self.data_of_platform_market
    platforms = []
    Platform.all.each do |platform|
      coins= []
      coins << Price.data_for_each_coin(1, platform.id)
      coins << Price.data_for_each_coin(2, platform.id)

      platforms << coins
    end
    return platforms
  end

  def self.data_for_each_coin(coin, platform)

    search= Price.search(
      where: {coin_id: coin, platform_id: platform},
      body_options: {
        aggs: {
          by_times: {
            date_histogram: {
              field: :created_at,
              interval: "5m",

            },
            aggs: {
              highest: {
                top_hits: {
                  sort: [
                    {
                      worth: {
                        order: "desc"
                      }
                    }
                  ],
                  _source: {
                    includes: ["worth"]
                  },
                  size: 1
                }
              },
              lowest: {
                top_hits: {
                  sort: [
                    {
                      worth: {
                        order: "asc"
                      }
                    }
                  ],
                  _source: {
                    includes: ["worth"]
                  },
                  size: 1
                }
              },
              open: {
                top_hits: {
                  sort: [
                    {
                      created_at: {
                        order: "asc"
                      }
                    }
                  ],
                  _source: {
                    includes: ["worth", "created_at"]
                  },
                  size: 1
                }
              },
              close: {
                top_hits: {
                  sort: [
                    {
                      created_at: {
                        order: "desc"
                      }
                    }
                  ],
                  _source: {
                    includes: ["worth"]
                  },
                  size: 1
                }
              }
            }
          }
        }
      }
    )

    return [] unless search.aggregations.present?
    block_time_agg = search.aggregations.dig("by_times", "buckets")
    block_time_agg.inject([]) {|by_times, i|
    by_times <<
      if(i.dig("lowest", "hits","hits").present? )
        Hashie::Mash.new(
          id: i.dig("key"),
          date: i.dig("open","hits","hits").first.dig("_source","created_at"),
          open: i.dig("open","hits","hits").first.dig("_source","worth"),
          high: i.dig("highest", "hits","hits").first.dig("_source","worth"),
          low:  i.dig("lowest", "hits","hits").first.dig("_source","worth"),
          close: i.dig("close","hits","hits").first.dig("_source","worth")
          )
      end
    }

  end



  def self.request_price
    prices = []
    #basecoin platform
    arr_coinbase = [{api: "BTC-USD", platform: "Coinbase", coin: "Bitcoin"},{api: "ETH-USD", platform: "Coinbase", coin: "Ethereum"}];

    #bittrex platform
    arr_bittrex = [{api: "usdt-btc", platform: "Bittrex", coin: "Bitcoin"},{api: "usdt-eth", platform: "Bittrex", coin: "Ethereum"}];

    arr_coinbase.each do |arr|
      _price = request_data_basecoin(arr[:api])
      price = Price.create!(worth: _price, coin_id: Coin.find_by_name(arr[:coin]).id, platform_id: Platform.find_by_name(arr[:platform]).id)
      prices << price
    end

    arr_bittrex.each do |arr|
      _price = Price.request_data_bittrex(arr[:api])
      price = Price.create!(worth: _price, coin_id: Coin.find_by_name(arr[:coin]).id, platform_id: Platform.find_by_name(arr[:platform]).id)
      prices << price
    end
    return prices
  end






















  def self.request_data_basecoin(currency)
    require 'httparty'
    url ='https://api.coinbase.com/v2/prices/' + currency
    url = url + '/spot'
    response = HTTParty.get(url)
        worth= response.parsed_response['data']['amount']
    return worth
  end


  def self.request_data_bittrex(currency)
    require 'httparty'
    url ='https://bittrex.com/api/v1.1/public/getmarketsummary?market=' + currency
    response = HTTParty.get(url)
    worth= response.parsed_response['result'].first['Bid']
    return worth
  end

  def self.request_data_poloniex(currency)
    require 'httparty'
    url ='https://poloniex.com/public?command=returnOrderBook&currencyPair=' + currency
    url = url + '&depth=1'
    response = HTTParty.get(url)
    worth = response.parsed_response['bids'].first['0']
    return worth
  end


end
