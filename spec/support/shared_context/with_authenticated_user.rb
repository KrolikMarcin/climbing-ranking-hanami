RSpec.shared_context 'with authenticated user' do
  let(:user) { create(:user) }
  let(:session) { { user_id: user.id, session_start_time: Time.now} }
end
