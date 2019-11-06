module Web
  module Views
    module Sessions
      class New
        include Web::View

        def form
          Form.new(:session, routes.sessions_path)
        end
      end
    end
  end
end
