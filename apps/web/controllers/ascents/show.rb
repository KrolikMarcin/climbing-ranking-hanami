require_relative './../authentication'

module Web
  module Controllers
    module Ascents
      class Show
        include Web::Action
        include Web::Controllers::Authentication
        expose :ascent

        def call(params)
          @ascent = AscentRepository
                    .new
                    .find_with_line_and_user(params.get(:id))

          halt(404, 'Not found') if @ascent.nil?
        end
      end
    end
  end
end
