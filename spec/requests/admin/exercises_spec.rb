# rubocop:disable RSpec/MultipleMemoizedHelpers, RSpec/MultipleExpectations
require "rails_helper"

RSpec.describe "Admin::Exercises", type: :request do
  let!(:body_part) { create(:body_part).tap { |record| create(:body_part_translation, body_part: record, locale: "en", name: "Chest") } }
  let!(:muscle_group) { create(:muscle_group).tap { |record| create(:muscle_group_translation, muscle_group: record, locale: "en", name: "Pectorals") } }
  let!(:equipment_type) { create(:equipment_type).tap { |record| create(:equipment_type_translation, equipment_type: record, locale: "en", name: "Barbell") } }
  let!(:tag) { create(:tag).tap { |record| create(:tag_translation, tag: record, locale: "en", name: "Compound") } }

  let(:create_params) do
    {
      key: "barbell_bench_press",
      active: "1",
      body_part_id: body_part.id,
      muscle_group_id: muscle_group.id,
      equipment_type_id: equipment_type.id,
      tag_ids: [ tag.id ],
      translations: {
        en: { name: "Bench Press", description: "Flat barbell press", synonyms_csv: "bench, chest press" },
        ru: { name: "Жим лежа", description: "Жим штанги лежа", synonyms_csv: "жим, грудь" }
      }
    }
  end

  describe "GET /admin/exercises" do
    context "when unauthenticated" do
      before { get admin_exercises_path }

      it "redirects to sign in" do
        expect(response).to redirect_to(new_session_path)
      end
    end

    context "when authenticated as a member" do
      include_context "with authenticated user"

      before { get admin_exercises_path }

      it "redirects to the home page" do
        expect(response).to redirect_to(root_path)
      end
    end

    context "when authenticated as an admin" do
      include_context "with authenticated admin"

      before do
        exercise = create(:exercise, body_part:, muscle_group:, equipment_type:)
        create(:exercise_translation, exercise:, locale: "en", name: "Bench Press")
        create(:exercise_translation, exercise:, locale: "ru", name: "Жим лежа")
        exercise.tags << tag
        get admin_exercises_path
      end

      it "returns success" do
        expect(response).to have_http_status(:ok)
      end

      it "renders localized exercises" do
        expect(response.body).to include("Bench Press")
        expect(response.body).to include("Жим лежа")
      end
    end
  end

  describe "GET /admin/exercises/new" do
    include_context "with authenticated admin"

    before { get new_admin_exercise_path }

    it "returns success" do
      expect(response).to have_http_status(:ok)
    end
  end

  describe "POST /admin/exercises" do
    subject(:perform_request) { post admin_exercises_path, params: { exercise: create_params } }

    include_context "with authenticated admin"

    it "creates an exercise" do
      expect { perform_request }.to change(Exercise, :count).by(1)
    end

    it "creates translations" do
      expect { perform_request }.to change(ExerciseTranslation, :count).by(2)
    end

    it "redirects to the index" do
      perform_request

      expect(Exercise.order(:created_at).last.key).to eq("barbell_bench_press")
      expect(response).to redirect_to(admin_exercises_path)
    end

    context "with invalid attributes" do
      let(:create_params) do
        super().tap { |value| value[:translations][:en][:name] = "" }
      end

      it "does not create an exercise" do
        expect { perform_request }.not_to change(Exercise, :count)
      end

      it "returns unprocessable content" do
        perform_request

        expect(response).to have_http_status(:unprocessable_content)
      end
    end
  end

  describe "PATCH /admin/exercises/:id" do
    subject(:perform_request) { patch admin_exercise_path(exercise), params: { exercise: update_params } }

    include_context "with authenticated admin"

    let(:exercise) do
      create(:exercise, body_part:, muscle_group:, equipment_type:).tap do |record|
        create(:exercise_translation, exercise: record, locale: "en", name: "Before EN")
        create(:exercise_translation, exercise: record, locale: "ru", name: "До RU")
      end
    end
    let(:update_params) do
      create_params.merge(
        active: "0",
        translations: {
          en: { name: "After EN", description: "Updated", synonyms_csv: "press, chest" },
          ru: { name: "После RU", description: "Обновлено", synonyms_csv: "жим, грудь" }
        }
      )
    end

    it "updates the exercise and translations" do
      perform_request

      reloaded_exercise = Exercise.find(exercise.id)
      expect(reloaded_exercise).not_to be_active
      expect(reloaded_exercise.localized_name(:en)).to eq("After EN")
      expect(reloaded_exercise.localized_name(:ru)).to eq("После RU")
    end
  end

  describe "DELETE /admin/exercises/:id" do
    subject(:perform_request) { delete admin_exercise_path(exercise) }

    include_context "with authenticated admin"

    let!(:exercise) do
      create(:exercise, body_part:, muscle_group:, equipment_type:).tap do |record|
        create(:exercise_translation, exercise: record, locale: "en", name: "Bench Press")
        create(:exercise_translation, exercise: record, locale: "ru", name: "Жим лежа")
      end
    end

    it "deletes the exercise" do
      expect { perform_request }.to change(Exercise, :count).by(-1)
    end

    it "redirects to the index" do
      perform_request

      expect(response).to redirect_to(admin_exercises_path)
    end
  end
end
# rubocop:enable RSpec/MultipleMemoizedHelpers, RSpec/MultipleExpectations
