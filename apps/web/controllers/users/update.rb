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
          return set_user unless params.valid?

          ::Users::CreateOrUpdateTransaction
            .new
            .with_step_args(create_or_update: [current_user.id])
            .call(params, &method(:handle_transaction))
        end

        private

        def handle_transaction(monad)
          monad.success do
            flash[:success] = 'The user has been updated'
            redirect_to routes.user_path(id: current_user.id)
          end

          monad.failure(:create_or_update) { params.errors.add(:user, :email, 'is not unique') }
        end

        def set_user
          @user = current_user
        end
      end
    end
  end
end
