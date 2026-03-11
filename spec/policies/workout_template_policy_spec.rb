require "rails_helper"

RSpec.describe WorkoutTemplatePolicy do
  let(:record) { create(:workout_template) }

  shared_examples "allows authenticated creation flow" do |policy_method|
    it "allows access" do
      expect(described_class.new(user, record).public_send(policy_method)).to be(true)
    end
  end

  shared_examples "allows only the owner" do |policy_method|
    context "when the user owns the template" do
      let(:user) { record.user }

      it "allows access" do
        expect(described_class.new(user, record).public_send(policy_method)).to be(true)
      end
    end

    context "when the user does not own the template" do
      let(:user) { create(:user) }

      it "denies access" do
        expect(described_class.new(user, record).public_send(policy_method)).to be(false)
      end
    end
  end

  describe "when the user is anonymous" do
    it_behaves_like "denies anonymous access", :index?
    it_behaves_like "denies anonymous access", :new?
    it_behaves_like "denies anonymous access", :create?
    it_behaves_like "denies anonymous access", :show?
    it_behaves_like "denies anonymous access", :edit?
    it_behaves_like "denies anonymous access", :update?
    it_behaves_like "denies anonymous access", :destroy?
  end

  describe "when the user is authenticated" do
    let(:user) { create(:user) }

    it_behaves_like "allows authenticated creation flow", :index?
    it_behaves_like "allows authenticated creation flow", :new?
    it_behaves_like "allows authenticated creation flow", :create?
  end

  describe "owner-only actions" do
    it_behaves_like "allows only the owner", :show?
    it_behaves_like "allows only the owner", :edit?
    it_behaves_like "allows only the owner", :update?
    it_behaves_like "allows only the owner", :destroy?
  end
end
