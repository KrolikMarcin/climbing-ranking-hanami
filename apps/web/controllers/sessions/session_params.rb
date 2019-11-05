module Web
  module Controllers
    module Sessions
      class SessionParams < Web::Action::Params
        params do
          required(:session).schema do
            required(:password).filled(:str?)
            required(:email).filled(:str?, format?: /@/)
          end
        end
      end
    end
  end
end
