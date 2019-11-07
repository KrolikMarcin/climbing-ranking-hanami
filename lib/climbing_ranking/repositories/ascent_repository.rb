class AscentRepository < Hanami::Repository
  associations do
    belongs_to :user
    belongs_to :line
  end

  def find_with_line_and_user(id)
    aggregate(:line, :user).where(id: id).map_to(Ascent).one
  end
end
