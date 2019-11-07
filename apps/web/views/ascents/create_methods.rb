module Web
  module Views
    module Ascents
      module CreateMethods
        include Web::View

        def self.included(view)
          view.class_eval do
            def form
              Form.new(:ascent, routes.ascents_path)
            end

            def submit_label
              'Add ascent'
            end

            def styles
              Ascent::STYLE_POINTS.keys.reduce({}) { |memo, style| memo.merge(style.to_s => style) }
            end

            def kinds
              {
                line: :line,
                boulder: :boulder
              }
            end

            def grades
              Line::GRADES.reduce({}) { |memo, grade| memo.merge(grade.to_s => grade) }
            end
          end
        end
      end
    end
  end
end
