require "rails_helper"

RSpec.describe MuscleGroup, type: :model do
  it { is_expected.to have_many(:muscle_group_translations).dependent(:destroy) }
  it { is_expected.to have_many(:exercises).dependent(:restrict_with_exception) }

  it_behaves_like "localized entity", :muscle_group, :muscle_group_translation, "Грудные"
end
