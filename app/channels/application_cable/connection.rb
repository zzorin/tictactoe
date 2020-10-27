module ApplicationCable
  class Connection < ActionCable::Connection::Base
    identified_by :current_user

    def connect
      params = request.query_parameters()
      puts "ApplicationCable::Connection => connect #{ params }"
      # WEB API
      access_token = params["access_token"]
      uid = params["uid"]
      client = params["client"]
      self.current_user = find_verified_user access_token, uid, client
      logger.info "ActionCable => connected user: #{ current_user.email }"
    end

    private
      def find_verified_user token, uid, client_id
        verified_user = User.find_by(id: uid)
        if verified_user#&& verified_user.valid_token?(token, client_id)
          verified_user
        else
          reject_unauthorized_connection
        end
      end
  end
end
