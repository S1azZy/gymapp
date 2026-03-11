require "rails_helper"

RSpec.describe TagTranslation, type: :model do
  subject(:tag_translation) { build(:tag_translation) }

  before do
    create(:tag_translation)
  end

  it_behaves_like "translation model", :tag

  it { is_expected.to validate_uniqueness_of(:locale).scoped_to(:tag_id).ignoring_case_sensitivity }
end
