RSpec.describe Web::Controllers::Ascents::Create, type: :action do
  let(:action) { described_class.new }
  let(:response) { action.call(params) }

  context 'when user is authenticated' do
    let(:params) { { 'rack.session' => session, ascent: ascent_params } }

    include_context 'with authenticated user'

    context 'when params are valid' do
      let(:ascent_params) do
        {
          date: Date.new(2019, 10, 10),
          style: 'os',
          belayer: Faker::Name.name,
          line: attributes_for(:line)
        }
      end
      let(:ascent_id) { AscentRepository.new.last.id }

      it { expect(response).to have_http_status(302) }
      it { expect(response).to redirect_to("/ascents/#{ascent_id}") }
    end

    context 'when params are invalid' do
      let(:ascent_params) { {} }

      it { expect(response).to have_http_status(400) }
    end
  end

  context 'when user is not authenticated' do
    let(:params) { {} }

    it_behaves_like 'user is not authenticated'
  end
end
