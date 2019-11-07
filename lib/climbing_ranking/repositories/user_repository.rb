class UserRepository < Hanami::Repository
  associations do
    has_many :ascents
    has_many :lines, through: :ascents
  end

  def find_by_email(email)
    users.where(email: email).one!
  end
end
