module Sessions
  class CreateSessionTransaction
    include Dry::Transaction

    try :find_user, catch: ROM::TupleCountMismatchError
    check :user_authenticated?
    map :login_user

    private

    def find_user(email)
      UserRepository.new.find_by_email(email)
    end

    def user_authenticated?(user, password:)
      BCrypt::Password.new(user.hashed_pass) == password
    end

    def login_user(user, session:)
      session[:user_id] = user.id
      session[:session_start_time] = Time.now
    end
  end
end
