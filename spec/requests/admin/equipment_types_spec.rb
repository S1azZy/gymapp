require "rails_helper"

RSpec.describe "Admin::EquipmentTypes", type: :request do
  it_behaves_like "admin localized reference management" do
    let(:collection_path_helper) { :admin_equipment_types_path }
    let(:new_path_helper) { :new_admin_equipment_type_path }
    let(:member_path_helper) { :admin_equipment_type_path }
    let(:destroy_path_helper) { :admin_equipment_type_path }
    let(:resource_param_key) { :equipment_type }
    let(:factory_name) { :equipment_type }
    let(:translation_factory_name) { :equipment_type_translation }
    let(:translation_model_class) { EquipmentTypeTranslation }
    let(:model_class) { EquipmentType }
    let(:owner_key) { :equipment_type }
  end
end
