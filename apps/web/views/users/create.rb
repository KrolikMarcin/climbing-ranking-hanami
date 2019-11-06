module Web
  module Views
    module Users
      class Create
        include Web::View
        template 'users/new'

        def form
          Form.new(:user, routes.users_path)
        end

        def submit_label
          'Create User'
        end
      end
    end
  end
end
