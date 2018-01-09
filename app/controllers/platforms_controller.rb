class PlatformsController < ApplicationController

  def show
    @platforms = Platform.first
    @price = Price.new
    @btc_newest_cb = request_data_basecoin("BTC-USD")
    @eth_newest_cb = request_data_basecoin("ETH-USD")
    @btc_newest_bt = request_data_bittrex("usdt-btc")
    @eth_newest_bt = request_data_bittrex("usdt-eth")

  end

  # def fetch_platforms
  #   @platforms= Platform.all
  #   respond_to do |format|
  #     format.json { render json: @platforms }
  #   end

  # end

  def fecth_coins_platform
    puts params[:platform]
    if (params[:platform] == "1" || params[:platform] == "2" || params[:platform] == "3")
      platform = Platform.find_by_id(params[:platform])
    else
      platform = Platform.find_by_id(1)
    end
      coins = platform.coins.distinct
    render json: coins.to_json
  end

  def index
    @platforms = Platform.all
  end


end