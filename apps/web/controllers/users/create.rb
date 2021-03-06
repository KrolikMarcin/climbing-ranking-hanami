require_relative './user_params'

module Web
  module Controllers
    module Users
      class Create
        include Web::Action
        params UserParams

        def call(params)
          return self.status = 400 unless params.valid?

          ::Users::CreateOrUpdateTransaction.new.call(user_params, &method(:handle_transaction))
        end

        private

        def handle_transaction(monad)
          monad.success do
            flash[:success] = 'The user has been created'
            redirect_to routes.path(:root)
          end

          monad.failure(:create_or_update) do
            self.status = 422
            params.errors.add(:user, :email, 'is not unique')
          end
        end

        def user_params
          params.get(:user)
        end
      end
    end
  end
end
