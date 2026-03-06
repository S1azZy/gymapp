require "rails_helper"

RSpec.describe Auth::Users::Create do
  describe ".call" do
    subject(:result) { described_class.call(**params) }

    let(:params) do
      {
        email: "new-user@example.com",
        password: "supersecure123",
        password_confirmation: "supersecure123"
      }
    end

    it "returns success for valid attributes" do
      expect(result).to be_success
    end

    it "persists the created user" do
      expect { result }.to change(User, :count).by(1)
    end

    it "normalizes the user email" do
      normalized_result = described_class.call(**params.merge(email: " NEW-USER@example.com "))

      expect(normalized_result.value!.email).to eq("new-user@example.com")
    end

    context "with invalid attributes" do
      let(:params) do
        super().merge(password_confirmation: "mismatch-password")
      end

      it "returns failure" do
        expect(result).to be_failure
      end

      it "returns validation errors" do
        expect(result.failure[:code]).to eq(:invalid_attributes)
      end
    end
  end
end
