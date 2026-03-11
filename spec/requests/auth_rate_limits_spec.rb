require "rails_helper"

RSpec.describe "Auth rate limits", type: :request do
  shared_examples "a rate-limited auth endpoint" do
    before do
      5.times { perform_request }
    end

    it "redirects after the limit is reached" do
      perform_request

      expect(response).to redirect_to(redirect_path)
    end

    it "shows the rate limit message" do
      perform_request

      expect(flash[:alert]).to eq(I18n.t("auth.flash.rate_limited"))
    end
  end

  describe "POST /session" do
    let!(:user) { create(:user, email: "member@example.com", password: "supersecure123") }
    let(:session_payload) do
      {
        session: {
          email: user.email,
          password: "wrong-password"
        }
      }
    end

    let(:redirect_path) { new_session_path }

    it_behaves_like "a rate-limited auth endpoint"

    def perform_request
      post session_path, params: session_payload
    end
  end

  describe "POST /password_resets" do
    let!(:user) { create(:user, email: "member@example.com") }
    let(:password_reset_payload) do
      {
        password_reset: {
          email: user.email
        }
      }
    end

    let(:redirect_path) { new_password_reset_path }

    it_behaves_like "a rate-limited auth endpoint"

    def perform_request
      post password_resets_path, params: password_reset_payload
    end
  end

  describe "POST /users" do
    let(:user_payload) do
      {
        user: {
          email: "new-member@example.com",
          password: "supersecure123",
          password_confirmation: "supersecure123"
        }
      }
    end

    let(:redirect_path) { new_user_path }

    it_behaves_like "a rate-limited auth endpoint"

    def perform_request
      post users_path, params: user_payload
    end
  end
end
