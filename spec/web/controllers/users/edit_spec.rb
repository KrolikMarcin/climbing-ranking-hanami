RSpec.describe Web::Controllers::Users::Edit, type: :action do
  let(:action) { described_class.new }
  let(:response) { action.call(params) }

  context 'when user is authenticated' do
    let(:params) { { 'rack.session' => session } }

    include_context 'with authenticated user'

    it { expect(response).to have_http_status(200) }
  end

  context 'when user is not authenticated' do
    let(:params) { {} }

    it_behaves_like 'user is not authenticated'
  end
end
