require_relative './user_params'

module Web
  module Controllers
    module Users
      class Create
        include Web::Action
        params UserParams

        def call(params)
          return self.status = 422 unless params.valid?

          ::Users::CreateOrUpdateTransaction.new.call(params) { |m| handle_transaction(m) }
        end

        private

        def handle_transaction(monad)
          monad.success do
            flash[:success] = 'The user has been created'
            redirect_to routes.path(:root)
          end

          monad.failiure(:create_or_update) do
            self.status = 422
            params.errors.add(:user, :email, 'is not unique')
          end
        end
      end
    end
  end
end
