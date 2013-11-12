module Api
  module V1
    class UsersController < ApiController
      def current
        render json: current_user.as_json
      end
    end
  end
end
