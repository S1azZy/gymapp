require "rails_helper"

RSpec.describe ExerciseTag, type: :model do
  subject(:exercise_tag) { build(:exercise_tag) }

  before do
    create(:exercise_tag)
  end

  it { is_expected.to belong_to(:exercise) }
  it { is_expected.to belong_to(:tag) }
  it { is_expected.to validate_presence_of(:exercise) }
  it { is_expected.to validate_presence_of(:tag) }
  it { is_expected.to validate_uniqueness_of(:tag_id).scoped_to(:exercise_id).ignoring_case_sensitivity }
end
