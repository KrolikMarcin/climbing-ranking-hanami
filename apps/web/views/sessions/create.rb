module Web
  module Views
    module Sessions
      class Create
        include Web::View
        template 'sessions/new'

        def form
          Form.new(:session, routes.sessions_path)
        end
      end
    end
  end
end
