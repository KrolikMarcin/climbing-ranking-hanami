require_relative './create_methods'

module Web
  module Views
    module Ascents
      class New
        include Web::View
        include Web::Views::Ascents::CreateMethods
      end
    end
  end
end
