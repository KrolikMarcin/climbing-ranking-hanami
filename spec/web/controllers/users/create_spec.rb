RSpec.describe Web::Controllers::Users::Create, type: :action do
  let(:action) { described_class.new }
  let(:response) { action.call(params) }
  let(:params) { { user: user_params } }
  let(:user_params) do
    {
      name: Faker::Name.name,
      email: Faker::Internet.email,
      sex: false,
      date_of_birth: Faker::Date.birthday,
      password: Faker::Internet.password
    }
  end

  context 'when params are valid' do
    context 'when everything goes well' do
      it { expect(response).to have_http_status(302) }
      it { expect(response).to redirect_to('/') }
    end

    context 'when given email is not unique' do
      let(:user) { create(:user) }

      before { user_params.merge!(email: user.email) }

      it { expect(response).to have_http_status(422) }
    end
  end

  context 'when params are invalid' do
    let(:user_params) { {} }

    it { expect(response).to have_http_status(400) }
  end
end
