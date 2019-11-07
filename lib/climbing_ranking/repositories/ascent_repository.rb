class AscentRepository < Hanami::Repository
  associations do
    belongs_to :user
    belongs_to :line
  end
end
