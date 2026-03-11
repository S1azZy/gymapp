require "rails_helper"

RSpec.describe EquipmentTypeTranslation, type: :model do
  subject(:equipment_type_translation) { build(:equipment_type_translation) }

  before do
    create(:equipment_type_translation)
  end

  it_behaves_like "translation model", :equipment_type

  it { is_expected.to validate_uniqueness_of(:locale).scoped_to(:equipment_type_id).ignoring_case_sensitivity }
end
