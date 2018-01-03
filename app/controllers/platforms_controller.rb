class PlatformsController < ApplicationController
  # COINBASE_API_KEY =  'hHrryo8GTvEUdlln'
  # COINBASE_CLIENT_SECRET = 'W4PY3IXWyAuBpWwVIgmvD0NRD18cUBBu'
  def show
    # @platform = Platform.first
    # @prices = @platform.prices
    @btc_newest_bc = request_data_basecoin("BTC-USD")
    @eth_newest_bc = request_data_basecoin("ETH-USD")
    @btc_newest_bt = request_data_bittrex("usdt-btc")
    @eth_newest_bt = request_data_bittrex("usdt-eth")
    @btc_newest_po = request_data_poloniex("USDT_BTC")
    @eth_newest_po = request_data_poloniex("USDT_ETH")
    # require 'coinbase/wallet'
    # client = Coinbase::Wallet::Client.new(api_key: COINBASE_API_KEY, api_secret: COINBASE_CLIENT_SECRET)
    #
  end


end