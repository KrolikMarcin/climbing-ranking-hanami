require_relative './user_params'
require_relative './../authentication'

module Web
  module Controllers
    module Users
      class Update
        include Web::Action
        include Web::Controllers::Authentication
        params UserParams
        expose :user

        def call(params)
          return handle_invalid_params unless params.valid?

          ::Users::CreateOrUpdateTransaction
            .new
            .with_step_args(create_or_update: [current_user.id])
            .call(user_params, &method(:handle_transaction))
        end

        private

        def handle_transaction(monad)
          monad.success do
            flash[:success] = 'The user has been updated'
            redirect_to routes.user_path(id: current_user.id)
          end

          monad.failure(:create_or_update) do
            self.status = 422
            params.errors.add(:user, :email, 'is not unique')
          end
        end

        def handle_invalid_params
          @user = current_user
          self.status = 400
        end

        def user_params
          params.get(:user)
        end
      end
    end
  end
end
