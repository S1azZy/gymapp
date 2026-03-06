require "rails_helper"

RSpec.describe DashboardPolicy, type: :policy do
  subject(:policy) { described_class.new(current_user, record) }

  let(:record) { :dashboard }

  context "when the user is anonymous" do
    let(:current_user) { nil }

    it_behaves_like "denies anonymous access", :show?
  end

  context "when the user is authenticated" do
    let(:current_user) { create(:user) }

    it "allows access" do
      expect(policy.show?).to be(true)
    end
  end
end
