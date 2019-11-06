require_relative './../authentication'

module Web
  module Controllers
    module Sessions
      class Destroy
        include Web::Action
        include Web::Controllers::Authentication

        def call(_params)
          session.clear
          redirect_to routes.new_session_path
        end
      end
    end
  end
end
