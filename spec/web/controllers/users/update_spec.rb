RSpec.describe Web::Controllers::Users::Update, type: :action do
  let(:action) { described_class.new }
  let(:response) { action.call(params) }

  context 'when user is authenticated' do
    let(:params) { { 'rack.session' => session, user: user_params } }
    let(:user_params) do
      {
        name: Faker::Name.name,
        email: Faker::Internet.email,
        sex: false,
        date_of_birth: Faker::Date.birthday,
        password: Faker::Internet.password
      }
    end

    include_context 'with authenticated user'

    context 'when params are valid' do
      it { expect(response[0]).to eq 302 }
    end

    context 'when params are invalid' do
      let(:user_params) { {} }
      it { expect(response[0]).to eq 400 }
    end

    context 'when given email is not unique' do
      let(:another_user) { create(:user) }

      before { user_params.merge!(email: another_user.email) }

      it { expect(response[0]).to eq 422 }
    end
  end

  context 'when user is not authenticated' do
    let(:params) { {} }

    it_behaves_like 'user is not authenticated'
  end
end
