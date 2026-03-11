require "rails_helper"

RSpec.describe "Exercises", type: :request do
  let!(:body_part) { create(:body_part, position: 10).tap { |record| create(:body_part_translation, body_part: record, locale: "en", name: "Upper body") } }
  let!(:muscle_group) { create(:muscle_group, position: 10).tap { |record| create(:muscle_group_translation, muscle_group: record, locale: "en", name: "Chest") } }
  let!(:equipment_type) { create(:equipment_type, position: 10).tap { |record| create(:equipment_type_translation, equipment_type: record, locale: "en", name: "Barbell") } }
  let!(:tag) { create(:tag, position: 10).tap { |record| create(:tag_translation, tag: record, locale: "en", name: "Compound") } }
  let!(:exercise) do
    create(:exercise, key: "barbell_bench_press", body_part:, muscle_group:, equipment_type:).tap do |record|
      record.tags << tag
      create(:exercise_translation, exercise: record, locale: "en", name: "Bench Press", description: "Flat press", synonyms: [ "bench", "chest press" ])
      create(:exercise_translation, exercise: record, locale: "ru", name: "Жим лежа", description: "Жим штанги лежа", synonyms: [ "жим" ])
    end
  end

  describe "GET /exercises" do
    context "when unauthenticated" do
      before { get exercises_path }

      it "redirects to sign in" do
        expect(response).to redirect_to(new_session_path)
      end
    end

    context "when authenticated" do
      include_context "with authenticated user"

      before { get exercises_path }

      it "returns success" do
        expect(response).to have_http_status(:ok)
      end

      it "renders the exercise name" do
        expect(response.body).to include("Bench Press")
      end
    end

    context "with filters" do
      include_context "with authenticated user"

      it "filters by body part" do
        get exercises_path, params: { filters: { body_part_id: body_part.id } }

        expect(response.body).to include("Bench Press")
      end

      it "filters by search query matching synonyms" do
        get exercises_path, params: { filters: { query: "chest press" } }

        expect(response.body).to include("Bench Press")
      end
    end
  end

  describe "GET /exercises/:id" do
    context "when unauthenticated" do
      before { get exercise_path(exercise) }

      it "redirects to sign in" do
        expect(response).to redirect_to(new_session_path)
      end
    end

    context "when authenticated" do
      include_context "with authenticated user"

      before { get exercise_path(exercise) }

      it "returns success" do
        expect(response).to have_http_status(:ok)
      end

      it "renders the exercise details" do
        expect(response.body).to include("Bench Press")
        expect(response.body).to include("Flat press")
      end
    end
  end
end
