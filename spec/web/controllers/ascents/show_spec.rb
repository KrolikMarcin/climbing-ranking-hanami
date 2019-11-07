RSpec.describe Web::Controllers::Ascents::Show, type: :action do
  let(:action) { described_class.new }
  let(:response) { action.call(params) }

  context 'when user is authenticated' do
    let(:params) { { 'rack.session' => session, id: id } }

    include_context 'with authenticated user'

    context 'when ascent id exists' do
      let(:id) { create(:ascent).id }

      it { expect(response).to have_http_status(200) }
    end

    context 'when ascent id not exists' do
      let(:id) { 10 }

      it { expect(response).to have_http_status(404) }
    end
  end

  context 'when user is not authenticated' do
    let(:params) { {} }

    it_behaves_like 'user is not authenticated'
  end
end
