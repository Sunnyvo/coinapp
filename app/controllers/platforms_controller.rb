class PlatformsController < ApplicationController
  # COINBASE_API_KEY =  'hHrryo8GTvEUdlln'
  # COINBASE_CLIENT_SECRET = 'W4PY3IXWyAuBpWwVIgmvD0NRD18cUBBu'
  def show
    @platforms = Platform.first
    @price = Price.new
    @btc_newest_cb = request_data_basecoin("BTC-USD")
    @eth_newest_cb = request_data_basecoin("ETH-USD")
    @btc_newest_bt = request_data_bittrex("usdt-btc")
    @eth_newest_bt = request_data_bittrex("usdt-eth")
    # @btc_newest_po = request_data_poloniex("USDT_BTC")
    # @eth_newest_po = request_data_poloniex("USDT_ETH")
    # require 'coinbase/wallet'
    # client = Coinbase::Wallet::Client.new(api_key: COINBASE_API_KEY, api_secret: COINBASE_CLIENT_SECRET)
    #
  end

  def fetch_platforms
    @platform= Platform.find_by_id(params[:id])
      # platform.coins.distince
    render json: @platform.to_json({ include: [Platform.coins_distinct(@platform)]})
    # render json: @students.to_json({ include: [ :languages, :nation_languages, :additional_skills] })
  end


end