class SessionsController < ApplicationController
  def create
    @user = User.where(email: params[:email]).first
    if @user&.valid_password?(params[:password])
      log_in(@user)
      respond_to do |format|
      # render json: user.as_json(only: [:email, :authentication_token]), status: :created
        format.json  {render :create,  status: :created}
      end
    else
      head(:unauthorized)
    end

  end
  def destroy
  end
end
