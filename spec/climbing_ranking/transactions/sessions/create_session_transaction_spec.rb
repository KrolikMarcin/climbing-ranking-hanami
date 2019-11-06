RSpec.describe Sessions::CreateSessionTransaction do
  let(:transaction_call) { transaction.call(email) }
  let(:transaction) do
    described_class
      .new
      .with_step_args(
        user_authenticated?: [password: password],
        login_user: [session: session]
      )
  end
  let(:session) { {} }
  let(:password) { 'password' }
  let(:user) { create(:user) }
  let(:email) { user.email }

  context 'when everything goes well' do
    it 'returns success' do
      expect(transaction_call.success?).to eq(true)
    end

    it 'adds user id to session' do
      transaction_call
      expect(session.fetch(:user_id)).to eq(user.id)
    end
  end

  context 'when given email not exists' do
    let(:email) { 'invalid email' }

    it 'fails on find_user step and raises ROM::TupleCountMismatchError' do
      expect(transaction).to fail_on(:find_user)
        .with(email).and_raise(ROM::TupleCountMismatchError)
    end
  end

  context 'when given password is invalid' do
    let(:password) { 'invalid password' }

    it 'fails on user_authenticated? step' do
      expect(transaction).to fail_on(:user_authenticated?).with(email)
    end
  end
end
