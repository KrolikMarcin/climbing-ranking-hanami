module Web
  module Controllers
    module Users
      class UserParams < Web::Action::Params
        params do
          required(:user).schema do
            required(:name).filled(:str?)
            required(:email).filled(:str?, format?: /@/)
            required(:password).filled(:str?)
            required(:date_of_birth).filled(:date?)
          end
        end
      end
    end
  end
end
