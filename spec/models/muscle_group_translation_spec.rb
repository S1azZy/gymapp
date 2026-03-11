require "rails_helper"

RSpec.describe MuscleGroupTranslation, type: :model do
  subject(:muscle_group_translation) { build(:muscle_group_translation) }

  before do
    create(:muscle_group_translation)
  end

  it_behaves_like "translation model", :muscle_group

  it { is_expected.to validate_uniqueness_of(:locale).scoped_to(:muscle_group_id).ignoring_case_sensitivity }
end
