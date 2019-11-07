require_relative './../authentication'

module Web
  module Controllers
    module Ascents
      class New
        include Web::Action
        include Web::Controllers::Authentication

        def call(_params); end
      end
    end
  end
end
