module ApplicationCable
  class Connection < ActionCable::Connection::Base
    identified_by :current_user

    def connect
      self.current_user = find_token_user
      logger.add_tags 'ActionCable', "User #{current_user.id}"
    end

    protected
      def find_token_user
        begin
          token = request.params[:token]
          if current_user = User.find_by(authentication_token: token)
            current_user
          else
            reject_unauthorized_connection
          end
        rescue
          reject_unauthorized_connection
        end
      end
  end
end
