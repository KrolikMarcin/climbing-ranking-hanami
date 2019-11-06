RSpec.describe Web::Controllers::Users::New, type: :action do
  let(:action) { described_class.new }
  let(:params) { Hash[] }
  let(:response) { action.call(params) }

  it { expect(response[0]).to eq 200 }
end
