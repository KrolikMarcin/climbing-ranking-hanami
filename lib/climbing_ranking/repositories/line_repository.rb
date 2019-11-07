class LineRepository < Hanami::Repository
  associations do
    has_many :ascents
    has_many :users, through: :ascents
  end
end
