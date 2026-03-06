require "rails_helper"

RSpec.describe "PasswordResets", type: :request do
  describe "GET /password_resets/new" do
    before do
      get new_password_reset_path
    end

    it "renders the password reset request page" do
      expect(response).to have_http_status(:ok)
    end

    it "shows the password reset heading" do
      expect(response.body).to include("Reset password")
    end
  end

  describe "POST /password_resets" do
    subject(:perform_request) { post password_resets_path, params: password_reset_params }

    let!(:user) { create(:user, email: "member@example.com") }
    let(:password_reset_params) { { password_reset: { email: user.email } } }

    before do
      ActionMailer::Base.deliveries.clear
    end

    it "creates a reset token for an existing user" do
      expect { perform_request }.to change(PasswordResetToken, :count).by(1)
    end

    it "sends a reset email for an existing user" do
      expect { perform_request }.to change(ActionMailer::Base.deliveries, :count).by(1)
    end

    it "redirects to sign in with a generic notice" do
      perform_request

      expect(response).to redirect_to(new_session_path)
    end
  end

  describe "POST /password_resets for an unknown email" do
    subject(:perform_request) { post password_resets_path, params: password_reset_params }

    let(:password_reset_params) { { password_reset: { email: "missing@example.com" } } }

    before do
      ActionMailer::Base.deliveries.clear
    end

    it "does not create a reset token" do
      expect { perform_request }.not_to change(PasswordResetToken, :count)
    end

    it "does not send an email" do
      expect { perform_request }.not_to change(ActionMailer::Base.deliveries, :count)
    end

    it "still redirects to sign in" do
      perform_request

      expect(response).to redirect_to(new_session_path)
    end
  end

  describe "PATCH /password_resets/:id" do
    subject(:perform_request) do
      patch password_reset_path(password_reset_token.id, token: token), params: password_reset_params
    end

    let(:user) { create(:user, password: "supersecure123", password_confirmation: "supersecure123") }
    let(:token) { raw_token }
    let(:password_reset_params) do
      {
        password_reset: {
          password: "evenmoresecure123",
          password_confirmation: "evenmoresecure123"
        }
      }
    end

    before do
      create(:user_session, user:)
      post password_resets_path, params: { password_reset: { email: user.email } }
    end

    it "updates the user password for a valid token" do
      perform_request

      expect(user.reload.authenticate("evenmoresecure123")).to eq(user)
    end

    it "invalidates active sessions after reset" do
      expect { perform_request }.to change(UserSession, :count).by(-1)
    end

    it "redirects to sign in after a successful reset" do
      perform_request

      expect(response).to redirect_to(new_session_path)
    end

    context "with an invalid token" do
      let(:token) { "wrong-token" }

      it "rejects the reset request" do
        perform_request

        expect(response).to redirect_to(new_password_reset_path)
      end
    end

    context "when the token is reused" do
      before do
        perform_request
      end

      it "does not allow the same token to be reused" do
        patch password_reset_path(password_reset_token.id, token: raw_token), params: password_reset_params

        expect(response).to redirect_to(new_password_reset_path)
      end
    end

    def password_reset_token
      PasswordResetToken.order(:created_at).last
    end

    def raw_token
      ActionMailer::Base.deliveries.last.body.encoded[%r{token=([^"\s]+)}, 1]
    end
  end
end
