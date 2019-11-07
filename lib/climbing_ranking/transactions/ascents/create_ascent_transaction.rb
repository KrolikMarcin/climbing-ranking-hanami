module Ascents
  class CreateAscentTransaction
    include Dry::Transaction

    try :find_or_create_line, catch: [
      Hanami::Model::UnknownAttributeError, Hanami::Model::NotNullConstraintViolationError
    ]
    try :calculate_ascent_points, catch: KeyError
    try :create_ascent, catch: Hanami::Model::NotNullConstraintViolationError

    private

    def find_or_create_line(line_params)
      line_repo.find_line(filter: line_params) || line_repo.create(line_params)
    end

    def calculate_ascent_points(line, ascent:)
      {
        line: line,
        ascent_params: ascent.merge(
          points: calculate_points(line.grade, ascent.fetch(:style))
        )
      }
    end

    def create_ascent(input, user:)
      ::AscentRepository.new.create(
        input[:ascent_params].merge(
          line_id: input[:line].id, user_id: user.id
        )
      )
    end

    def calculate_points(grade, style)
      Ascent::STYLE_POINTS.fetch(style.to_sym) + Line::GRADES.find_index(grade) * 50
    end

    def line_repo
      ::LineRepository.new
    end
  end
end
