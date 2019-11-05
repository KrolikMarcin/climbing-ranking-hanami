module Web
  module Controllers
    module Authentication
      SESSION_TIME = 3600

      def self.included(action)
        action.class_eval do
          before :authenticate_user!
          expose :current_user
        end
      end

      private

      def authenticate_user!
        return redirect_to routes.new_session_path if !authenticated? || session_expired?

        session[:session_start_time] = Time.now
      end

      def current_user
        @current_user ||= UserRepository.new.find(session[:user_id])
      end

      def authenticated?
        !current_user.nil?
      end

      def session_expired?
        session[:session_start_time] + SESSION_TIME < Time.now
      end
    end
  end
end
