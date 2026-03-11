require "rails_helper"

RSpec.describe "Admin::MuscleGroups", type: :request do
  it_behaves_like "admin localized reference management" do
    let(:collection_path_helper) { :admin_muscle_groups_path }
    let(:new_path_helper) { :new_admin_muscle_group_path }
    let(:member_path_helper) { :admin_muscle_group_path }
    let(:destroy_path_helper) { :admin_muscle_group_path }
    let(:resource_param_key) { :muscle_group }
    let(:factory_name) { :muscle_group }
    let(:translation_factory_name) { :muscle_group_translation }
    let(:translation_model_class) { MuscleGroupTranslation }
    let(:model_class) { MuscleGroup }
    let(:owner_key) { :muscle_group }
  end
end
