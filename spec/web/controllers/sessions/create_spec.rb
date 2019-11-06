RSpec.describe Web::Controllers::Sessions::Create, type: :action do
  let(:action) { described_class.new }
  let(:response) { action.call(params) }

  context 'when params are valid' do
    let(:params) do
      {
        session: {
          email: email, password: password
        }
      }
    end
    let(:user) { create(:user) }
    let(:password) { 'password' }
    let(:email) { user.email }

    context 'when eveyrthing goes well' do
      it { expect(response[0]).to eq 302 }
    end

    context 'when given email not exists' do
      let(:email) { 'invalid@google.com' }

      it { expect(response[0]).to eq 404 }
    end

    context 'when password is ivalid' do
      let(:password) { 'invalid password' }

      it { expect(response[0]).to eq 422 }
    end
  end

  context 'when params are invalid' do
    let(:params) { {} }

    it { expect(response[0]).to eq 400 }
  end
end
