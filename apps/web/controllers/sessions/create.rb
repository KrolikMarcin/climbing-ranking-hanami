require_relative './session_params'

module Web
  module Controllers
    module Sessions
      class Create
        include Web::Action
        params SessionParams

        def call(params)
          return self.status = 422 unless params.valid?

          create_session_transaction.call(email) { |m| handle_transaction(m) }
        end

        private

        def create_session_transaction
          ::Sessions::CreateSessionTransaction
            .new
            .with_step_args(
              user_authenticated?: [password: password],
              login_user: [session: session]
            )
        end

        def handle_transaction(monad)
          monad.success { redirect_to routes.root_path }
          monad.failure(:find_user) do
            self.status = 404
            params.errors.add(:session, :email, 'not exists')
          end
          monad.failure(:user_authenticated?) do
            self.status = 422
            params.errors.add(:session, :password, 'is invalid')
          end
        end

        def password
          params.get(:session).fetch(:password)
        end

        def email
          params.get(:session).fetch(:email)
        end
      end
    end
  end
end
