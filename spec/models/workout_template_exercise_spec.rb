require "rails_helper"

RSpec.describe WorkoutTemplateExercise, type: :model do
  subject(:workout_template_exercise) { build(:workout_template_exercise) }

  before do
    create(:workout_template_exercise)
  end

  it { is_expected.to belong_to(:workout_template) }
  it { is_expected.to belong_to(:exercise) }
  it { is_expected.to validate_presence_of(:workout_template) }
  it { is_expected.to validate_presence_of(:exercise) }
  it { is_expected.to validate_presence_of(:position) }

  it do
    expect(workout_template_exercise).to validate_uniqueness_of(:position)
      .scoped_to(:workout_template_id)
  end

  it do
    expect(workout_template_exercise).to validate_numericality_of(:position)
      .only_integer
      .is_greater_than(0)
  end

  it do
    expect(workout_template_exercise).to validate_numericality_of(:planned_sets_count)
      .only_integer
      .is_greater_than(0)
      .allow_nil
  end

  it do
    expect(workout_template_exercise).to validate_numericality_of(:target_reps_min)
      .only_integer
      .is_greater_than(0)
      .allow_nil
  end

  it do
    expect(workout_template_exercise).to validate_numericality_of(:target_reps_max)
      .only_integer
      .is_greater_than(0)
      .allow_nil
  end

  it do
    expect(workout_template_exercise).to validate_numericality_of(:rest_seconds)
      .only_integer
      .is_greater_than_or_equal_to(0)
      .allow_nil
  end

  it { is_expected.to validate_length_of(:notes).is_at_most(2000) }

  describe "normalization" do
    before do
      workout_template_exercise.notes = "  Controlled eccentric  "
      workout_template_exercise.valid?
    end

    it "strips the notes" do
      expect(workout_template_exercise.notes).to eq("Controlled eccentric")
    end
  end

  describe "when target reps max is lower than target reps min" do
    subject(:validation_errors) do
      workout_template_exercise.target_reps_min = 10
      workout_template_exercise.target_reps_max = 8
      workout_template_exercise.valid?
      workout_template_exercise.errors[:target_reps_max]
    end

    it "adds an error" do
      expect(validation_errors).to include("must be greater than or equal to target reps min")
    end
  end
end
