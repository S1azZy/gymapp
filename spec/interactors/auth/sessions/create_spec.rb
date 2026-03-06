require "rails_helper"

RSpec.describe Auth::Sessions::Create do
  describe ".call" do
    subject(:result) { described_class.call(email:, password:) }

    let!(:user) { create(:user, email: "member@example.com", password: "supersecure123") }
    let(:email) { " MEMBER@example.com " }
    let(:password) { "supersecure123" }


    it "returns success for valid credentials" do
      expect(result).to be_success
    end

    it "returns the authenticated user for valid credentials" do
      expect(result.value!).to eq(user)
    end

    context "with invalid credentials" do
      let(:email) { "member@example.com" }
      let(:password) { "wrong-password" }

      it "returns failure" do
        expect(result).to be_failure
      end

      it "returns the invalid credentials error payload" do
        expect(result.failure).to eq(code: :invalid_credentials)
      end
    end
  end
end
