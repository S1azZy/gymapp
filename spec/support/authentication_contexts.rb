RSpec.shared_context "with authenticated user" do
  let(:user) { create(:user) }

  before do
    post session_path, params: {
      session: {
        email: user.email,
        password: "supersecure123"
      }
    }
  end
end

RSpec.shared_context "with authenticated admin" do
  let(:user) { create(:user, :admin) }

  before do
    post session_path, params: {
      session: {
        email: user.email,
        password: "supersecure123"
      }
    }
  end
end
