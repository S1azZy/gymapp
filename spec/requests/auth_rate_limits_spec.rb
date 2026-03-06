require "rails_helper"

RSpec.describe "Auth rate limits", type: :request do
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

    before do
      5.times { perform_request }
    end

    it "redirects after the limit is reached" do
      perform_request

      expect(response).to redirect_to(new_session_path)
    end

    it "shows the rate limit message" do
      perform_request

      expect(flash[:alert]).to eq(I18n.t("auth.flash.rate_limited"))
    end

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

    before do
      5.times { perform_request }
    end

    it "redirects after the limit is reached" do
      perform_request

      expect(response).to redirect_to(new_password_reset_path)
    end

    it "shows the rate limit message" do
      perform_request

      expect(flash[:alert]).to eq(I18n.t("auth.flash.rate_limited"))
    end

    def perform_request
      post password_resets_path, params: password_reset_payload
    end
  end
end
