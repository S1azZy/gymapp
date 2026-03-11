require "rails_helper"

RSpec.describe "Admin::Tags", type: :request do
  it_behaves_like "admin localized reference management" do
    let(:collection_path_helper) { :admin_tags_path }
    let(:new_path_helper) { :new_admin_tag_path }
    let(:member_path_helper) { :admin_tag_path }
    let(:destroy_path_helper) { :admin_tag_path }
    let(:resource_param_key) { :tag }
    let(:factory_name) { :tag }
    let(:translation_factory_name) { :tag_translation }
    let(:translation_model_class) { TagTranslation }
    let(:model_class) { Tag }
    let(:owner_key) { :tag }
  end
end
