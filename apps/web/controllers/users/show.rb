require_relative './../authentication'

module Web
  module Controllers
    module Users
      class Show
        include Web::Action
        include Web::Controllers::Authentication
        expose :user

        def call(params)
          @user = UserRepository
                  .new
                  .find(params.get(:id))
          # TODO: Find better option to handle invalid id
          halt(404, 'Not found') if @user.nil?
        end
      end
    end
  end
end
