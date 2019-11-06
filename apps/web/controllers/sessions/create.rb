require_relative './session_params'

module Web
  module Controllers
    module Sessions
      class Create
        include Web::Action
        params SessionParams

        def call(params)
          return self.status = 400 unless params.valid?

          create_session_transaction.call(email, &method(:handle_transaction))
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
          monad.success do
            flash[:success] = 'The user has been logged in'
            redirect_to routes.root_path
          end

          monad.failure(:find_user) { add_error(:email, 'not exists', 404) }
          monad.failure(:user_authenticated?) { add_error(:password, 'is invalid', 422) }
        end

        def password
          params.get(:session).fetch(:password)
        end

        def email
          params.get(:session).fetch(:email)
        end

        def add_error(attribute, message, status)
          params.errors.add(:session, attribute, message)
          self.status = status
        end
      end
    end
  end
end
