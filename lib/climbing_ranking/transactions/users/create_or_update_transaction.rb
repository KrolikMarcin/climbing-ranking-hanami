module Users
  class CreateOrUpdateTransaction
    include Dry::Transaction

    map :encrypt_password
    try :create_or_update, catch: Hanami::Model::UniqueConstraintViolationError

    private

    def encrypt_password(params)
      params
        .slice(:name, :email, :date_of_birth, :sex)
        .merge(
          hashed_pass: hashed_password(params.fetch(:password))
        )
    end

    def create_or_update(params, user_id = nil)
      return user_repo.update(user_id, params) if user_id

      user_repo.create(params)
    end

    def hashed_password(password)
      BCrypt::Password.create(password)
    end

    def user_repo
      UserRepository.new
    end
  end
end
