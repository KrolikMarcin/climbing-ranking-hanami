require_relative './../authentication'

module Web
  module Controllers
    module Users
      class Edit
        include Web::Action
        include Web::Controllers::Authentication

        expose :user

        def call(_params)
          @user = current_user
        end
      end
    end
  end
end
