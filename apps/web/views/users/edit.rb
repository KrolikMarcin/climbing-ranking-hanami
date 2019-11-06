module Web
  module Views
    module Users
      class Edit
        include Web::View
        template 'users/new'

        def form
          Form.new(
            :user,
            routes.user_path(id: user.id),
            { user: user },
            method: :patch
          )
        end

        def submit_label
          'Update User'
        end
      end
    end
  end
end
