module Web
  module Controllers
    module Ascents
      class AscentParams < Web::Action::Params
        params do
          required(:ascent).schema do
            required(:style).filled(:str?)
            required(:date).filled(:date?)
            required(:belayer).filled(:str?)

            required(:line).schema do
              required(:name).filled(:str?)
              required(:grade).filled(:str?)
              required(:crag).filled(:str?)
              required(:kind).filled(:str?)
            end
          end
        end
      end
    end
  end
end
