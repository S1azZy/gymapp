require "rails_helper"

RSpec.describe WorkoutTemplate, type: :model do
  subject(:workout_template) { build(:workout_template) }

  it { is_expected.to belong_to(:user) }
  it { is_expected.to have_many(:workout_template_exercises).dependent(:destroy) }
  it { is_expected.to have_many(:exercises).through(:workout_template_exercises) }
  it { is_expected.to validate_presence_of(:user) }
  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_length_of(:name).is_at_most(255) }
  it { is_expected.to validate_length_of(:notes).is_at_most(2000) }

  describe "normalization" do
    before do
      workout_template.name = "  Upper Body A  "
      workout_template.notes = "  Keep rest short  "
      workout_template.valid?
    end

    it "strips the template name" do
      expect(workout_template.name).to eq("Upper Body A")
    end

    it "strips the template notes" do
      expect(workout_template.notes).to eq("Keep rest short")
    end
  end
end
