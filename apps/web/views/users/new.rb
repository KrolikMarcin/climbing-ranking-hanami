module Web
  module Views
    module Users
      class New
        include Web::View

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
