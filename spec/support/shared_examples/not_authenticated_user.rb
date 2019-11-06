shared_examples 'user is not authenticated' do
  it { expect(response[0]).to eq 302 }
end
