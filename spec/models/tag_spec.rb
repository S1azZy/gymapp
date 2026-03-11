require "rails_helper"

RSpec.describe Tag, type: :model do
  it { is_expected.to have_many(:tag_translations).dependent(:destroy) }
  it { is_expected.to have_many(:exercise_tags).dependent(:destroy) }
  it { is_expected.to have_many(:exercises).through(:exercise_tags) }

  it_behaves_like "keyed catalog entity", :tag
  it_behaves_like "localized entity", :tag, :tag_translation, "Силовое"
end
