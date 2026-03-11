# rubocop:disable RSpec/MultipleMemoizedHelpers, RSpec/MultipleExpectations
RSpec.shared_examples "admin localized reference management" do
  subject(:perform_create) { post collection_path, params: { resource_param_key => create_params } }

  let(:collection_path) { public_send(collection_path_helper) }
  let(:new_path) { public_send(new_path_helper) }
  let(:destroy_path) { public_send(destroy_path_helper, record) }
  let(:update_path) { public_send(member_path_helper, record) }
  let(:record) { create(factory_name) }
  let(:create_params) do
    {
      active: "1",
      translations: {
        en: { name: "English name" },
        ru: { name: "Русское имя" }
      }
    }
  end

  describe "GET index" do
    context "when unauthenticated" do
      before { get collection_path }

      it "redirects to sign in" do
        expect(response).to redirect_to(new_session_path)
      end
    end

    context "when authenticated as a member" do
      include_context "with authenticated user"

      before { get collection_path }

      it "redirects to the home page" do
        expect(response).to redirect_to(root_path)
      end
    end

    context "when authenticated as an admin" do
      include_context "with authenticated admin"

      before do
        create(translation_factory_name, owner_key => record, locale: "en", name: "English name")
        create(translation_factory_name, owner_key => record, locale: "ru", name: "Русское имя")
        get collection_path
      end

      it "returns success" do
        expect(response).to have_http_status(:ok)
      end

      it "renders localized records" do
        expect(response.body).to include("English name")
        expect(response.body).to include("Русское имя")
      end
    end
  end

  describe "GET new" do
    include_context "with authenticated admin"

    before { get new_path }

    it "returns success" do
      expect(response).to have_http_status(:ok)
    end
  end

  describe "POST create" do
    include_context "with authenticated admin"

    it "creates a base record" do
      expect { perform_create }.to change(model_class, :count).by(1)
    end

    it "creates translations for both locales" do
      expect { perform_create }.to change(translation_model_class, :count).by(2)
    end

    it "redirects to the collection" do
      perform_create

      expect(response).to redirect_to(collection_path)
    end

    context "with invalid attributes" do
      let(:create_params) do
        {
          active: "1",
          translations: {
            en: { name: "" },
            ru: { name: "" }
          }
        }
      end

      it "does not create a record" do
        expect { perform_create }.not_to change(model_class, :count)
      end

      it "returns unprocessable entity" do
        perform_create

        expect(response).to have_http_status(:unprocessable_content)
      end
    end
  end

  describe "PATCH update" do
    subject(:perform_update) { patch update_path, params: { resource_param_key => update_params } }

    include_context "with authenticated admin"

    let(:record) do
      create(factory_name).tap do |created_record|
        create(translation_factory_name, owner_key => created_record, locale: "en", name: "Before EN")
        create(translation_factory_name, owner_key => created_record, locale: "ru", name: "До RU")
      end
    end
    let(:update_params) do
      {
        active: "0",
        translations: {
          en: { name: "After EN" },
          ru: { name: "После RU" }
        }
      }
    end

    it "updates the record and translations" do
      perform_update

      expect(record.reload).not_to be_active
      expect(model_class.find(record.id).localized_name(:en)).to eq("After EN")
      expect(model_class.find(record.id).localized_name(:ru)).to eq("После RU")
    end
  end

  describe "DELETE destroy" do
    subject(:perform_destroy) { delete destroy_path }

    include_context "with authenticated admin"

    let(:record) do
      create(factory_name).tap do |created_record|
        create(translation_factory_name, owner_key => created_record, locale: "en", name: "Delete EN")
        create(translation_factory_name, owner_key => created_record, locale: "ru", name: "Удалить RU")
      end
    end

    it "deletes the record" do
      record
      expect { perform_destroy }.to change(model_class, :count).by(-1)
    end

    it "redirects to the collection" do
      perform_destroy

      expect(response).to redirect_to(collection_path)
    end
  end
end
# rubocop:enable RSpec/MultipleMemoizedHelpers, RSpec/MultipleExpectations
