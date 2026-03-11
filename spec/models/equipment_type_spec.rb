require "rails_helper"

RSpec.describe EquipmentType, type: :model do
  it { is_expected.to have_many(:equipment_type_translations).dependent(:destroy) }
  it { is_expected.to have_many(:exercises).dependent(:restrict_with_exception) }

  it_behaves_like "keyed catalog entity", :equipment_type
  it_behaves_like "localized entity", :equipment_type, :equipment_type_translation, "Штанга"
end
