shared_examples 'user is not authenticated' do
  it { expect(response).to have_http_status(302) }
  it { expect(response).to redirect_to('/sessions/new') }
end
