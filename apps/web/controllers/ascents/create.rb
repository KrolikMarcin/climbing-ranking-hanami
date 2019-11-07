require_relative './../authentication'
require_relative './ascent_params'

module Web
  module Controllers
    module Ascents
      class Create
        include Web::Action
        include Web::Controllers::Authentication
        params AscentParams

        def call(params)
          return self.status = 400 unless params.valid?

          create_ascent_transaction.call(line) do |m|
            m.success { |ascent| redirect_to routes.ascent_path(id: ascent.id) }
          end
        end

        private

        def create_ascent_transaction
          ::Ascents::CreateAscentTransaction
            .new
            .with_step_args(
              calculate_ascent_points: [ascent: ascent],
              create_ascent: [user: current_user]
            )
        end

        def line
          params.get(:ascent, :line)
        end

        def ascent
          params.get(:ascent).slice(:style, :date, :belayer)
        end
      end
    end
  end
end
