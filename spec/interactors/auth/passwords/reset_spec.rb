require "rails_helper"

RSpec.describe Auth::Passwords::Reset do
  describe ".call" do
    subject(:result) do
      described_class.call(
        password_reset_token:,
        password:,
        password_confirmation:
      )
    end

    let(:user) { create(:user, password: "supersecure123", password_confirmation: "supersecure123") }
    let(:password_reset_token) { create(:password_reset_token, user:) }
    let(:password) { "evenmoresecure123" }
    let(:password_confirmation) { password }

    before do
      create(:user_session, user:)
    end

    it "returns success for valid password attributes" do
      expect(result).to be_success
    end

    it "updates the user password" do
      result

      expect(user.reload.authenticate(password)).to eq(user)
    end

    it "invalidates existing user sessions" do
      expect { result }.to change(UserSession, :count).by(-1)
    end

    it "marks reset tokens as used" do
      result

      expect(password_reset_token.reload.used_at).to be_present
    end

    context "with an invalid password confirmation" do
      let(:password_confirmation) { "mismatch-password" }

      it "returns failure" do
        expect(result).to be_failure
      end
    end
  end
end
