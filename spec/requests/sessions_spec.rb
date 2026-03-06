require "rails_helper"

RSpec.describe "Sessions", type: :request do
  describe "GET /session/new" do
    before do
      get new_session_path
    end

    it "renders the sign-in page" do
      expect(response).to have_http_status(:ok)
    end

    it "shows the sign-in heading" do
      expect(response.body).to include("Sign in")
    end
  end

  describe "POST /session" do
    subject(:perform_request) { post session_path, params: session_params }

    let!(:user) { create(:user, email: "member@example.com", password: "supersecure123") }
    let(:session_params) { { session: { email: user.email, password: "supersecure123" } } }

    it "creates a user session for valid credentials" do
      expect { perform_request }.to change(UserSession, :count).by(1)
    end

    it "redirects valid credentials to the dashboard" do
      perform_request

      expect(response).to redirect_to(dashboard_path)
    end

    it "creates a persisted session linked to the user" do
      perform_request

      expect(UserSession.order(:created_at).last.user_id).to eq(user.id)
    end
  end

  describe "POST /session with invalid credentials" do
    subject(:perform_request) { post session_path, params: session_params }

    let!(:user) { create(:user, email: "member@example.com", password: "supersecure123") }
    let(:session_params) { { session: { email: user.email, password: "wrong-password" } } }

    it "does not create a user session" do
      expect { perform_request }.not_to change(UserSession, :count)
    end

    it "returns an unprocessable entity response" do
      perform_request

      expect(response).to have_http_status(:unprocessable_content)
    end
  end

  describe "DELETE /session" do
    subject(:perform_request) { delete session_path }

    let(:user) { create(:user) }

    before do
      post session_path, params: { session: { email: user.email, password: "supersecure123" } }
    end

    it "destroys the current user session" do
      expect do
        perform_request
      end.to change(UserSession, :count).by(-1)
    end

    it "redirects to the home page" do
      perform_request

      expect(response).to redirect_to(root_path)
    end
  end
end
