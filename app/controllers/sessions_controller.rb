class SessionsController < ApplicationController
  def create
    @user = User.where(email: params[:email]).first
    if @user&.valid_password?(params[:password])
      log_in(@user)
      puts current_user.authentication_token
      respond_to do |format|
        format.json  {render :create,  status: :created}
      end
    else
      head(:unauthorized)
    end

  end
  def destroy
  end
end
