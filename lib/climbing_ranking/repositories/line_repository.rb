class LineRepository < Hanami::Repository
  associations do
    has_many :ascents
    has_many :users, through: :ascents
  end

  def find_line(filter: {})
    filter.reduce(lines) do |memo, (attr, value)|
      memo.where(lines[attr].is(value))
    end.one
  end
end
