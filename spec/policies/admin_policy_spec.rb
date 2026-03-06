require "rails_helper"

RSpec.describe AdminPolicy, type: :policy do
  subject(:policy) { described_class.new(current_user, record) }

  let(:record) { :admin }

  context "when the user is anonymous" do
    let(:current_user) { nil }

    it_behaves_like "denies anonymous access", :access?
  end

  context "when the user is a member" do
    let(:current_user) { create(:user) }

    it "denies access" do
      expect(policy.access?).to be(false)
    end
  end

  context "when the user is an admin" do
    let(:current_user) { create(:user, :admin) }

    it "allows access" do
      expect(policy.access?).to be(true)
    end
  end
end
