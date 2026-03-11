require "rails_helper"

RSpec.describe BodyPartTranslation, type: :model do
  subject(:body_part_translation) { build(:body_part_translation) }

  before do
    create(:body_part_translation)
  end

  it_behaves_like "translation model", :body_part

  it { is_expected.to validate_uniqueness_of(:locale).scoped_to(:body_part_id).ignoring_case_sensitivity }
end
