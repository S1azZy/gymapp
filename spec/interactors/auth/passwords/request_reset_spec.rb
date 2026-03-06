require "rails_helper"

RSpec.describe Auth::Passwords::RequestReset do
  describe ".call" do
    subject(:result) { described_class.call(email:) }

    let!(:user) { create(:user, email: "member@example.com") }
    let(:email) { user.email }

    before do
      ActionMailer::Base.deliveries.clear
    end

    it "returns success for an existing user" do
      expect(result).to be_success
    end

    it "creates a password reset token for an existing user" do
      expect { result }.to change(PasswordResetToken, :count).by(1)
    end

    it "sends a password reset email for an existing user" do
      expect { result }.to change(ActionMailer::Base.deliveries, :count).by(1)
    end

    context "with an unknown email" do
      let(:email) { "missing@example.com" }

      it "returns success" do
        expect(result).to be_success
      end

      it "does not create tokens" do
        expect { result }.not_to change(PasswordResetToken, :count)
      end
    end
  end
end
