# rubocop:disable RSpec/MultipleMemoizedHelpers, RSpec/MultipleExpectations
require "rails_helper"

RSpec.describe WorkoutTemplatePolicy, type: :policy do
  subject(:policy) { described_class.new(user, workout_template) }

  let(:owner) { create(:user) }
  let(:user) { owner }
  let(:workout_template) { create(:workout_template, user: owner) }

  permissions :index?, :new?, :create? do
    it "allows authenticated users" do
      expect(policy.index?).to be(true)
      expect(policy.new?).to be(true)
      expect(policy.create?).to be(true)
    end

    context "when unauthenticated" do
      let(:user) { nil }

      it "denies access" do
        expect(policy.index?).to be(false)
        expect(policy.new?).to be(false)
        expect(policy.create?).to be(false)
      end
    end
  end

  permissions :show?, :edit?, :update?, :destroy? do
    it "allows the owner" do
      expect(policy.show?).to be(true)
      expect(policy.edit?).to be(true)
      expect(policy.update?).to be(true)
      expect(policy.destroy?).to be(true)
    end

    context "when the user does not own the template" do
      let(:user) { create(:user) }

      it "denies access" do
        expect(policy.show?).to be(false)
        expect(policy.edit?).to be(false)
        expect(policy.update?).to be(false)
        expect(policy.destroy?).to be(false)
      end
    end
  end

  describe "Scope" do
    subject(:resolved_scope) { described_class::Scope.new(user, WorkoutTemplate.all).resolve }

    let(:owned_template) { create(:workout_template, user: owner) }
    let(:other_template) { create(:workout_template) }

    before do
      owned_template
      other_template
    end

    it "returns only owned templates" do
      expect(resolved_scope).to contain_exactly(owned_template)
    end

    context "when unauthenticated" do
      let(:user) { nil }

      it "returns no templates" do
        expect(resolved_scope).to be_empty
      end
    end
  end
end
# rubocop:enable RSpec/MultipleMemoizedHelpers, RSpec/MultipleExpectations
