RSpec.describe Users::CreateOrUpdateTransaction do
  let(:transaction_call) { transaction.call(params) }
  let(:transaction) { described_class.new }
  let(:params) do
    {
      name: Faker::Name.name,
      email: Faker::Internet.email,
      sex: false,
      date_of_birth: Faker::Date.birthday,
      password: Faker::Internet.password
    }
  end
  let(:user_repo) { UserRepository.new }

  context 'when everything goes well' do
    let(:proper_attributes) { params.slice(:name, :email, :sex) }

    context 'when user id is not given' do

      it 'returns success' do
        expect(transaction_call.success?).to eq(true)
      end

      it 'creates user' do
        expect { transaction_call }.to change(user_repo.users, :count).by(1)
      end

      it 'creates user with proper attributes', :aggregate_failures do
        expect(transaction_call.success).to include(proper_attributes)
        expect(transaction_call.success.date_of_birth.to_date).to eq(params[:date_of_birth])
        expect(BCrypt::Password.new(transaction_call.success.hashed_pass)).to eq(params[:password])
      end
    end

    context 'when user id is given' do
      let!(:user) { create(:user) }
      let(:transaction) { described_class.new.with_step_args(create_or_update: [user.id]) }
      let(:updated_user) { user_repo.find(user.id) }

      it 'returns success' do
        expect(transaction_call.success?).to eq(true)
      end

      it "doesn't create user" do
        expect { transaction_call }.to change(user_repo.users, :count).by(0)
      end

      it 'updates user with proper attributes' do
        expect(transaction_call.success).to include(proper_attributes)
        expect(transaction_call.success.date_of_birth.to_date).to eq(params[:date_of_birth])
        expect(BCrypt::Password.new(transaction_call.success.hashed_pass)).to eq(params[:password])
      end
    end
  end

  context 'when given email exists' do
    let(:user) { create(:user) }
    let(:new_params) { params.merge(email: user.email) }

    it 'fails on create_or_update step and raises Hanami::Model::UniqueConstraintViolationError' do
      expect(transaction).to fail_on(:create_or_update)
        .with(new_params).and_raise(Hanami::Model::UniqueConstraintViolationError)
    end
  end
end
