require "rails_helper"

RSpec.describe ExercisePolicy do
  let(:record) { create(:exercise) }

  describe "when the user is anonymous" do
    it_behaves_like "denies anonymous access", :index?
    it_behaves_like "denies anonymous access", :show?
  end

  describe "when the user is authenticated" do
    let(:user) { create(:user) }

    it "allows index access" do
      expect(described_class.new(user, record).index?).to be(true)
    end

    it "allows show access" do
      expect(described_class.new(user, record).show?).to be(true)
    end
  end
end
