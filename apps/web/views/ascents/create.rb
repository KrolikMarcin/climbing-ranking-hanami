require_relative './create_methods'

module Web
  module Views
    module Ascents
      class Create
        include Web::View
        include Web::Views::Ascents::CreateMethods

        template '/ascents/new'
      end
    end
  end
end
