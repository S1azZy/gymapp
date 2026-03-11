require "rails_helper"

RSpec.describe "Admin::BodyParts", type: :request do
  it_behaves_like "admin localized reference management" do
    let(:collection_path_helper) { :admin_body_parts_path }
    let(:new_path_helper) { :new_admin_body_part_path }
    let(:member_path_helper) { :admin_body_part_path }
    let(:destroy_path_helper) { :admin_body_part_path }
    let(:resource_param_key) { :body_part }
    let(:factory_name) { :body_part }
    let(:translation_factory_name) { :body_part_translation }
    let(:translation_model_class) { BodyPartTranslation }
    let(:model_class) { BodyPart }
    let(:owner_key) { :body_part }
  end
end
