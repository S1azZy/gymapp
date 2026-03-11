# rubocop:disable RSpec/MultipleMemoizedHelpers
require "rails_helper"

RSpec.describe Admin::Exercises::Upsert do
  subject(:result) { described_class.call(exercise:, exercise_attributes:) }

  let(:body_part) { create(:body_part).tap { |record| create(:body_part_translation, body_part: record, locale: "en", name: "Chest") } }
  let(:muscle_group) { create(:muscle_group).tap { |record| create(:muscle_group_translation, muscle_group: record, locale: "en", name: "Pectorals") } }
  let(:equipment_type) { create(:equipment_type).tap { |record| create(:equipment_type_translation, equipment_type: record, locale: "en", name: "Barbell") } }
  let(:tag) { create(:tag).tap { |record| create(:tag_translation, tag: record, locale: "en", name: "Compound") } }
  let(:exercise) { Exercise.new }
  let(:exercise_attributes) do
    {
      "key" => "barbell_bench_press",
      "active" => "1",
      "body_part_id" => body_part.id,
      "muscle_group_id" => muscle_group.id,
      "equipment_type_id" => equipment_type.id,
      "tag_ids" => [ tag.id ],
      "translations" => {
        "en" => { "name" => "Bench Press", "description" => "Flat barbell press", "synonyms_csv" => "bench, chest press" },
        "ru" => { "name" => "Жим лежа", "description" => "Жим штанги лежа", "synonyms_csv" => "жим, грудь" }
      }
    }
  end

  it "creates an exercise with translations and tags" do
    expect { result }.to change(Exercise, :count).by(1)
      .and change(ExerciseTranslation, :count).by(2)
      .and change(ExerciseTag, :count).by(1)
  end

  it "normalizes synonyms via the translation model" do
    result

    expect(result.value!.key).to eq("barbell_bench_press")
    expect(result.value!.translation_for(:en).synonyms).to eq([ "bench", "chest press" ])
  end

  context "with invalid translation data" do
    let(:exercise_attributes) do
      super().tap do |value|
        value["translations"]["en"]["name"] = ""
      end
    end

    it "returns a failure" do
      expect(result).to be_failure
    end

    it "does not persist the exercise" do
      expect { result }.not_to change(Exercise, :count)
    end
  end
end
# rubocop:enable RSpec/MultipleMemoizedHelpers
